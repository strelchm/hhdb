-- Specialization (group 4 professions)
CREATE TABLE specialisation
(
    id    BIGSERIAL PRIMARY KEY,
    title VARCHAR
);

-- Profession
CREATE TABLE spec_profession
(
    id                BIGSERIAL PRIMARY KEY,
    title             VARCHAR,
    specialisation_id BIGSERIAL,
    FOREIGN KEY (specialisation_id) REFERENCES specialisation (id)
);

-- Skill that is connected with profession (todo {strelchm}: skill to profession as many to many?)
CREATE TABLE skill
(
    id                 UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title              VARCHAR,
    spec_profession_id BIGSERIAL,
    FOREIGN KEY (spec_profession_id) REFERENCES spec_profession (id)
);

-- Employment type (connected to day scheduling)
CREATE TABLE employment_type
(
    id    BIGSERIAL PRIMARY KEY,
    title VARCHAR
);

-- Grouped work experience
CREATE TABLE work_experience
(
    id    BIGSERIAL PRIMARY KEY,
    title VARCHAR
);

-- todo {strelchm} - to expand regions to towns, cities etc
CREATE TABLE region
(
    id   BIGSERIAL PRIMARY KEY,
    name VARCHAR
);

CREATE TABLE organisation
(
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name        VARCHAR,
    description TEXT
);

CREATE TABLE hh_user
(
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    password    VARCHAR,
    create_date TIMESTAMP
);

-- hr from organization
CREATE TABLE employer
(
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name       VARCHAR,
    company_id UUID,
    user_id    UUID,
    FOREIGN KEY (user_id) REFERENCES hh_user (id),
    FOREIGN KEY (company_id) REFERENCES organisation (id)
);

CREATE TABLE employee
(
    id      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID,
    name    VARCHAR,
    FOREIGN KEY (user_id) REFERENCES hh_user (id)
);

CREATE TABLE resume
(
    id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title              VARCHAR,
    compensation_from  DOUBLE PRECISION,
    compensation_to    DOUBLE PRECISION,
    description        TEXT,
    area_id            BIGSERIAL,
    work_experience_id BIGSERIAL,
    employment_type_id BIGSERIAL,
    specialisation_id  BIGSERIAL,
    employee_id        UUID,
    create_date        TIMESTAMP,
    edit_date          TIMESTAMP,
    FOREIGN KEY (area_id) REFERENCES region (id),
    FOREIGN KEY (work_experience_id) REFERENCES work_experience (id),
    FOREIGN KEY (employment_type_id) REFERENCES employment_type (id),
    FOREIGN KEY (specialisation_id) REFERENCES specialisation (id),
    FOREIGN KEY (employee_id) REFERENCES employee (id)
);

CREATE TABLE resume_skills
(
    id        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    resume_id UUID,
    skill_id  UUID,
    FOREIGN KEY (resume_id) REFERENCES resume (id),
    FOREIGN KEY (skill_id) REFERENCES skill (id)
);

CREATE TABLE vacancy
(
    id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title              VARCHAR,
    description        TEXT,
    compensation_from  DOUBLE PRECISION,
    compensation_to    DOUBLE PRECISION,
    area_id            BIGSERIAL,
    work_experience_id BIGSERIAL,
    specialisation_id  BIGSERIAL,
    employment_type_id BIGSERIAL,
    hr_id              UUID,
    company_id         UUID,
    create_date        TIMESTAMP,
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
    vacancy_id UUID,
    skill_id   UUID,
    FOREIGN KEY (vacancy_id) REFERENCES vacancy (id),
    FOREIGN KEY (skill_id) REFERENCES skill (id)
);

-- can be both 4 resume and vacancy
CREATE TABLE response
(
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    resume_id   UUID,
    vacancy_id  UUID,
    company_id  UUID,
    employee_id UUID,
    employer_id UUID,
    create_date TIMESTAMP,
    FOREIGN KEY (resume_id) REFERENCES resume (id),
    FOREIGN KEY (vacancy_id) REFERENCES vacancy (id),
    FOREIGN KEY (company_id) REFERENCES organisation (id),
    FOREIGN KEY (employee_id) REFERENCES employee (id),
    FOREIGN KEY (employer_id) REFERENCES employer (id)
);

CREATE TABLE chat
(
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title       VARCHAR,
    response_id UUID,
    create_date TIMESTAMP,
    FOREIGN KEY (response_id) REFERENCES response (id)
);

CREATE TABLE message
(
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    text        TEXT,
    employee_id UUID,
    employer_id UUID,
    create_date TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employee (id),
    FOREIGN KEY (employer_id) REFERENCES employer (id)
);