-- Drop tables if they exist to reset the schema
DROP TABLE IF EXISTS student CASCADE;
DROP TABLE IF EXISTS organizer CASCADE;
DROP TABLE IF EXISTS dance_event CASCADE;
DROP TABLE IF EXISTS chat_group CASCADE;
DROP TABLE IF EXISTS study_material CASCADE;
DROP TABLE IF EXISTS software_system CASCADE;
DROP TABLE IF EXISTS student_event_participation CASCADE;
DROP TABLE IF EXISTS chat_group_members CASCADE;
DROP TABLE IF EXISTS material_access CASCADE;

-- Create student table
CREATE TABLE student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    student_group VARCHAR(50) NOT NULL
);

-- Create organizer table
CREATE TABLE organizer (
    organizer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    role VARCHAR(50) NOT NULL
);

-- Create dance_event table
CREATE TABLE dance_event (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    event_date DATE NOT NULL,
    location VARCHAR(100) NOT NULL,
    organizer_id INT NOT NULL,
    FOREIGN KEY (organizer_id) REFERENCES organizer (organizer_id)
);

-- Create chat_group table
CREATE TABLE chat_group (
    chat_id INT AUTO_INCREMENT PRIMARY KEY,
    chat_name VARCHAR(100) NOT NULL,
    topic VARCHAR(100),
    organizer_id INT NOT NULL,
    FOREIGN KEY (organizer_id) REFERENCES organizer (organizer_id)
);

-- Create study_material table
CREATE TABLE study_material (
    material_id INT AUTO_INCREMENT PRIMARY KEY,
    material_name VARCHAR(100) NOT NULL,
    material_type ENUM('video', 'document', 'image') NOT NULL
);

-- Create software_system table
CREATE TABLE software_system (
    system_id INT AUTO_INCREMENT PRIMARY KEY,
    system_name VARCHAR(100) NOT NULL
);

-- Create student_event_participation table
CREATE TABLE student_event_participation (
    participation_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    event_id INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student (student_id),
    FOREIGN KEY (event_id) REFERENCES dance_event (event_id)
);

-- Create chat_group_members table
CREATE TABLE chat_group_members (
    membership_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    chat_id INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student (student_id),
    FOREIGN KEY (chat_id) REFERENCES chat_group (chat_id)
);

-- Create material_access table
CREATE TABLE material_access (
    access_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    material_id INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student (student_id),
    FOREIGN KEY (material_id) REFERENCES study_material (material_id)
);

-- Add relationships between software_system and other tables
ALTER TABLE chat_group
    ADD COLUMN system_id INT,
    ADD FOREIGN KEY (system_id) REFERENCES software_system (system_id);

ALTER TABLE study_material
    ADD COLUMN system_id INT,
    ADD FOREIGN KEY (system_id) REFERENCES software_system (system_id);
