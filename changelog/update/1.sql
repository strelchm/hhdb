-- Specialization (group 4 professions)
CREATE TABLE specialisation
(
    id    bigserial PRIMARY KEY,
    title varchar
);

-- Profession
CREATE TABLE spec_profession
(
    id                bigserial PRIMARY KEY,
    title              varchar,
    specialisation_id bigserial,
    FOREIGN KEY (specialisation_id) REFERENCES specialisation (id)
);

-- Skill that is connected with profession (todo {strelchm}: skill to profession as many to many?)
CREATE TABLE skill
(
    id                 uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    title               varchar,
    spec_profession_id bigserial,
    FOREIGN KEY (spec_profession_id) REFERENCES spec_profession (id)
);

-- Employment type (connected to day scheduling)
CREATE TABLE employment_type
(
    id    bigserial PRIMARY KEY,
    title varchar
);

-- Grouped work experience
CREATE TABLE work_experience
(
    id    bigserial PRIMARY KEY,
    title varchar
);

-- todo {strelchm} - to expand regions to towns, cities etc
CREATE TABLE region
(
    id   bigserial PRIMARY KEY,
    name varchar
);

CREATE TABLE organisation
(
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name        varchar,
    description text
);

CREATE TABLE hh_user
(
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    password    varchar,
    create_date timestamp
);

-- hr from organization
CREATE TABLE employer
(
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name       varchar,
    company_id uuid,
    user_id    uuid,
    FOREIGN KEY (user_id) REFERENCES hh_user (id),
    FOREIGN KEY (company_id) REFERENCES organisation (id)
);

CREATE TABLE employee
(
    id      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id uuid,
    name    varchar,
    FOREIGN KEY (user_id) REFERENCES hh_user (id)
);

CREATE TABLE resume
(
    id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title              varchar,
    compensation_from  double precision,
    compensation_to    double precision,
    description        text,
    area_id            bigserial,
    work_experience_id bigserial,
    employment_type_id bigserial,
    specialisation_id  bigserial,
    employee_id        uuid,
    create_date        timestamp,
    edit_date          timestamp,
    FOREIGN KEY (area_id) REFERENCES region (id),
    FOREIGN KEY (work_experience_id) REFERENCES work_experience (id),
    FOREIGN KEY (employment_type_id) REFERENCES employment_type (id),
    FOREIGN KEY (specialisation_id) REFERENCES specialisation (id),
    FOREIGN KEY (employee_id) REFERENCES employee (id)
);

CREATE TABLE resume_skills
(
    id        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    resume_id uuid,
    skill_id  uuid,
    FOREIGN KEY (resume_id) REFERENCES resume (id),
    FOREIGN KEY (skill_id) REFERENCES skill (id)
);

CREATE TABLE vacancy
(
    id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title              varchar,
    description        text,
    compensation_from  double precision,
    compensation_to    double precision,
    area_id            bigserial,
    work_experience_id bigserial,
    specialisation_id  bigserial,
    employment_type_id bigserial,
    hr_id        uuid,
    company_id         uuid,
    create_date        timestamp,
    FOREIGN KEY (area_id) REFERENCES region (id),
    FOREIGN KEY (work_experience_id) REFERENCES work_experience (id),
    FOREIGN KEY (specialisation_id) REFERENCES specialisation (id),
    FOREIGN KEY (employment_type_id) REFERENCES employment_type (id),
    FOREIGN KEY (company_id) REFERENCES organisation (id),
    FOREIGN KEY (hr_id) REFERENCES employer (id)
);

CREATE TABLE vacancy_skills
(
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    vacancy_id uuid,
    skill_id   uuid,
    FOREIGN KEY (vacancy_id) REFERENCES vacancy (id),
    FOREIGN KEY (skill_id) REFERENCES skill (id)
);

-- can be both 4 resume and vacancy
CREATE TABLE response
(
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    resume_id   uuid,
    vacancy_id  uuid,
    company_id  uuid,
    employee_id uuid,
    employer_id uuid,
    create_date timestamp,
    FOREIGN KEY (resume_id) REFERENCES resume (id),
    FOREIGN KEY (vacancy_id) REFERENCES vacancy (id),
    FOREIGN KEY (company_id) REFERENCES organisation (id),
    FOREIGN KEY (employee_id) REFERENCES employee (id),
    FOREIGN KEY (employer_id) REFERENCES employer (id)
);

CREATE TABLE chat
(
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title       varchar,
    response_id uuid,
    create_date timestamp,
    FOREIGN KEY (response_id) REFERENCES response (id)
);

CREATE TABLE message
(
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    text        text,
    employee_id uuid,
    employer_id uuid,
    create_date timestamp,
    FOREIGN KEY (employee_id) REFERENCES employee (id),
    FOREIGN KEY (employer_id) REFERENCES employer (id)
);