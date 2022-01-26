INSERT INTO specialisation (title)
VALUES ('Автомобильный бизнес'),
       ('Административный персонал'),
       ('Безопасность'),
       ('Высший менеджмент'),
       ('Добыча сырья'),
       ('Домашний, обслуживающий персонал'),
       ('Закупки'),
       ('Информационные технологии'),
       ('Искусство, развлечения, масс-медиа'),
       ('Маркетинг, реклама, PR'),
       ('Медицина, фармацевтика'),
       ('Наука, образование'),
       ('Продажи, обслуживание клиентов'),
       ('Производство, сервисное обслуживание'),
       ('Рабочий персонал'),
       ('Розничная торговля'),
       ('Сельское хозяйство'),
       ('Спортивные клубы, фитнес, салоны красоты'),
       ('Стратегия, инвестиции, консалтинг'),
       ('Страхование'),
       ('Строительство, недвижимость'),
       ('Транспорт, логистика, перевозки'),
       ('Туризм, гостиницы, рестораны'),
       ('Управление персоналом, тренинги'),
       ('Финансы, бухгалтерия'),
       ('Юристы'),
       ('Другое');

INSERT INTO spec_profession (title, specialisation_id)
    (SELECT s.title || ' SPECIALIZATION ' || random_val, s.id
     FROM specialisation AS s,
          generate_series(0, 10) AS random_val);

INSERT INTO skill (title, spec_profession_id)
    (SELECT s.title || ' SKILL ' || random_val, s.id
     FROM spec_profession AS s,
          generate_series(0, 5) AS random_val);

INSERT INTO work_experience (title)
VALUES ('Нет опыта'),
       ('От 1 года до 3 лет'),
       ('От 3 до 6 лет'),
       ('Более 6 лет');

INSERT INTO employment_type (title)
VALUES ('Полная занятость'),
       ('Частичная занятость'),
       ('Проектная работа/разовое задание'),
       ('Волонтерство'),
       ('Стажировка');

INSERT INTO region (name)
VALUES ('Республика Марий Эл'),
       ('Республика Татарстан'),
       ('Удмуртская Республика'),
       ('Чувашская Республика'),
       ('Забайкальский край'),
       ('Иркутская область'),
       ('Красноярский край'),
       ('Республика Бурятия'),
       ('Республика Саха (Якутия)'),
       ('Республика Тыва'),
       ('Республика Хакасия'),
       ('Кировская область'),
       ('Нижегородская область'),
       ('Рязанская область'),
       ('Алтайский край'),
       ('Кемеровская область'),
       ('Новосибирская область'),
       ('Омская область'),
       ('Республика Алтай'),
       ('Томская область'),
       ('Москва'),
       ('Московская область'),
       ('Амурская область'),
       ('Еврейская АО'),
       ('Камчатский край'),
       ('Магаданская область'),
       ('Приморский край'),
       ('Сахалинская область'),
       ('Хабаровский край'),
       ('Чукотский АО'),
       ('Архангельская область'),
       ('Калининградская область'),
       ('Ленинградская область'),
       ('Мурманская область'),
       ('Ненецкий АО'),
       ('Новгородская область'),
       ('Псковская область'),
       ('Республика Карелия'),
       ('Республика Коми'),
       ('Санкт-Петербург'),
       ('Смоленская область'),
       ('Владимирская область'),
       ('Вологодская область'),
       ('Ивановская область'),
       ('Костромская область'),
       ('Тверская область'),
       ('Ярославская область'),
       ('Оренбургская область'),
       ('Пензенская область'),
       ('Республика Мордовия'),
       ('Самарская область'),
       ('Саратовская область'),
       ('Ульяновская область'),
       ('Курганская область'),
       ('Пермский край'),
       ('Республика Башкортостан'),
       ('Свердловская область'),
       ('Тюменская область'),
       ('Ханты-Мансийский АО - Югра'),
       ('Челябинская область'),
       ('Ямало-Ненецкий АО'),
       ('Кабардино-Балкарская республика'),
       ('Карачаево-Черкесская Республика'),
       ('Краснодарский край'),
       ('Республика Адыгея'),
       ('Республика Дагестан'),
       ('Республика Ингушетия'),
       ('Республика Северная Осетия-Алания'),
       ('Ставропольский край'),
       ('Чеченская республика'),
       ('Белгородская область'),
       ('Брянская область'),
       ('Воронежская область'),
       ('Калужская область'),
       ('Курская область'),
       ('Липецкая область'),
       ('Орловская область'),
       ('Тамбовская область'),
       ('Тульская область'),
       ('Астраханская область'),
       ('Республика Крым'),
       ('Волгоградская область'),
       ('Республика Калмыкия'),
       ('Ростовская область');

INSERT INTO organisation (name, description)
    (SELECT 'ORGANIZATION ' || random_val, 'SOME DESCRIPTION ' || random_val FROM generate_series(0, 10000) random_val);

WITH orgs AS (SELECT id FROM organisation),
     users AS (INSERT INTO hh_user (id, password, create_date)
             (SELECT orgs.id, 'PASSWORD', now()::timestamp FROM orgs) RETURNING id
     )
INSERT
INTO employer (name, company_id, user_id)
        (SELECT 'EMPLOYER ' || u.id, u.id, u.id FROM users u); --- todo {strelchm} now is simple...


WITH users AS (INSERT INTO hh_user (password, create_date)
    (SELECT 'PASSWORD', now()::timestamp FROM generate_series(0, 100000) AS random_val) RETURNING id
)
INSERT
INTO employee (name, user_id)
        (SELECT 'EMPLOYEE ' || u.id, u.id FROM users AS u);

WITH region_stat AS (SELECT (max(id) - min(id)) diff, min(id) min FROM region),
     work_experience_stat AS (SELECT (max(id) - min(id)) diff, min(id) min FROM work_experience),
     employment_type_stat AS (SELECT (max(id) - min(id)) diff, min(id) min FROM employment_type),
     specialisation_stat AS (SELECT (max(id) - min(id)) diff, min(id) min FROM specialisation),
     empl AS (SELECT id, random() compensation_koff FROM employee)
INSERT
INTO resume (title, compensation_from, compensation_to, description, area_id, work_experience_id, employment_type_id,
             specialisation_id, employee_id, create_date, edit_date)
    (SELECT 'RESUME ' || e.id,
            e.compensation_koff * 300000,
            (random() * (300000 - e.compensation_koff * 300000)) + e.compensation_koff * 300000,
            'DESCRIPTION ' || e.id,
            floor(random() * (SELECT diff FROM region_stat) + (SELECT min FROM region_stat)),
            floor(random() * (SELECT diff FROM work_experience_stat) + (SELECT min FROM work_experience_stat)),
            floor(random() * (SELECT diff FROM employment_type_stat) + (SELECT min FROM employment_type_stat)),
            floor(random() * (SELECT diff FROM specialisation_stat) + (SELECT min FROM specialisation_stat)),
            e.id,
            NOW() + (random() * (NOW()+'-31 days' - NOW())) + '-31 days',
            NOW() + (random() * (NOW()+'-31 days' - NOW())) + '-31 days'
     FROM empl AS e);

WITH res AS (SELECT id FROM resume)
INSERT
INTO resume_skills (resume_id, skill_id)
        (SELECT id, (SELECT id FROM skill WHERE random() < 0.7 LIMIT 1) FROM res);

WITH region_stat AS (SELECT (max(id) - min(id)) diff, min(id) min FROM region),
     work_experience_stat AS (SELECT (max(id) - min(id)) diff, min(id) min FROM work_experience),
     employment_type_stat AS (SELECT (max(id) - min(id)) diff, min(id) min FROM employment_type),
     specialisation_stat AS (SELECT (max(id) - min(id)) diff, min(id) min FROM specialisation),
     empl AS (SELECT id, random() compensation_koff, company_id FROM employer)
INSERT
INTO vacancy (title, compensation_from, compensation_to, description, area_id, work_experience_id, employment_type_id,
              specialisation_id, hr_id, company_id, create_date)
    (SELECT 'VACANCY ' || e.id,
            e.compensation_koff * 300000,
            (random() * (300000 - e.compensation_koff * 300000)) + e.compensation_koff * 300000,
            'DESCRIPTION ' || e.id,
            floor(random() * (SELECT diff FROM region_stat) + (SELECT min FROM region_stat)),
            floor(random() * (SELECT diff FROM work_experience_stat) + (SELECT min FROM work_experience_stat)),
            floor(random() * (SELECT diff FROM employment_type_stat) + (SELECT min FROM employment_type_stat)),
            floor(random() * (SELECT diff FROM specialisation_stat) + (SELECT min FROM specialisation_stat)),
            e.id,
            e.company_id,
            NOW() + (random() * (NOW()+'-31 days' - NOW())) + '-31 days'
     FROM empl AS e);

WITH vac AS (SELECT id FROM vacancy)
INSERT
INTO vacancy_skills (vacancy_id, skill_id)
        (SELECT id, (SELECT id FROM skill LIMIT 1) FROM vac);

WITH vac AS (SELECT id, company_id, hr_id FROM vacancy)
INSERT
INTO response (vacancy_id, employee_id, employer_id, company_id, create_date)
    (SELECT vac.id, (SELECT id FROM employee LIMIT 1), vac.hr_id, vac.company_id, NOW() + (random() * (NOW()+'-7 days' - NOW())) + '-7 days'
     FROM vac);

WITH res AS (SELECT id, employee_id, (SELECT id FROM employer LIMIT 1) rand_employer_id FROM resume)
INSERT
INTO response (resume_id, employee_id, employer_id, company_id, create_date)
    (SELECT res.id, res.employee_id, employer.id, employer.company_id, NOW() + (random() * (NOW()+'-7 days' - NOW())) + '-7 days'
     FROM res
              INNER JOIN employer ON res.rand_employer_id = employer.id);

WITH resp AS (SELECT id, create_date FROM response)
INSERT
INTO chat (title, response_id, create_date)
    (SELECT 'CHAT FOR RESPONSE ' || resp.id, resp.id, resp.create_date FROM resp);

INSERT INTO message (text, employee_id, employer_id, create_date)
    (SELECT 'MESSAGE FOR CHAT ' || chat.id, r.employee_id, r.employer_id, NOW() + (random() * (NOW()+'-7 days' - NOW())) + '-7 days'
     FROM chat
              INNER JOIN response r on r.id = chat.response_id);