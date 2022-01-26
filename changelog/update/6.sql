-- TABLE specialisation - NO INDEXES (ADDITIONAL TABLE)

-- TABLE spec_profession
CREATE INDEX ON spec_profession (specialisation_id);            -- 4 quick filtration on specialization field. The table spec_profession is small but performance will metter on thousands of requests

-- TABLE skill
CREATE INDEX ON skill (spec_profession_id);         -- 4 filter on spec_profession_id field

-- TABLE employment_type - NO INDEXES (ADDITIONAL TABLE)

-- TABLE work_experience - NO INDEXES (ADDITIONAL TABLE)

-- TABLE region - NO INDEXES (ADDITIONAL TABLE)

-- TABLE organisation
CREATE INDEX ON organisation (name);            -- 4 quick filtration by name

-- TABLE hh_user - NO INDEXES (ADDITIONAL TABLE)

-- TABLE employer
-- CREATE INDEX ON employer (name);     NO NEED TO FILTER BY FIO IN PUBLIC API - PERSONAL DATA

-- TABLE resume (MANY FIELDS ARE NECESSARY 4 FILTRATION)
CREATE INDEX ON resume (title);
CREATE INDEX ON resume (compensation_from);
CREATE INDEX ON resume (compensation_to);
CREATE INDEX ON resume (area_id);
CREATE INDEX ON resume (work_experience_id);
CREATE INDEX ON resume (employment_type_id);
CREATE INDEX ON resume (specialisation_id);
CREATE INDEX ON resume (employee_id);
CREATE INDEX ON resume (create_date);

-- TABLE resume_skills
CREATE INDEX ON resume_skills (resume_id);
CREATE INDEX ON resume_skills (skill_id);

-- TABLE vacancy (MANY FIELDS ARE NECESSARY 4 FILTRATION)
CREATE INDEX ON vacancy (title);
CREATE INDEX ON vacancy (compensation_from);
CREATE INDEX ON vacancy (compensation_to);
CREATE INDEX ON vacancy (area_id);
CREATE INDEX ON vacancy (work_experience_id);
CREATE INDEX ON vacancy (specialisation_id);
CREATE INDEX ON vacancy (employment_type_id);
CREATE INDEX ON vacancy (company_id);
CREATE INDEX ON vacancy (create_date);

-- TABLE vacancy_skills
CREATE INDEX ON vacancy_skills (vacancy_id);
CREATE INDEX ON vacancy_skills (vacancy_id);

-- TABLE response (MANY FIELDS ARE NECESSARY 4 FILTRATION)
CREATE INDEX ON response (resume_id);
CREATE INDEX ON response (vacancy_id);
CREATE INDEX ON response (company_id);
CREATE INDEX ON response (employee_id);
CREATE INDEX ON response (employer_id);
CREATE INDEX ON response (create_date);

-- TABLE chat (MANY FIELDS ARE NECESSARY 4 FILTRATION)
CREATE INDEX ON chat (title);
CREATE INDEX ON chat (response_id);
CREATE INDEX ON chat (create_date);

-- TABLE message
CREATE INDEX ON message (employee_id);
CREATE INDEX ON message (employer_id);
CREATE INDEX ON message (create_date);


-- P.S. AFTER INDEXES ADDING THE PLANNER MAKES EXPLAINS WITH FASTER RESULTS