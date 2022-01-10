/*
База по защитным  и морским покрытиям, которые применяются в России. 
основные задачи:
 - подбор покрытия или системы покрытий по заданным параметрам;
 - просмотр опыта использования систем покрытий на объектах;
 - извлечение основных свойств покрытия и комплекта документов в одном месте;
 

*/
DROP DATABASE IF EXISTS coatings;
CREATE DATABASE coatings;
USE coatings;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  	id INT UNSIGNED NOT NULL PRIMARY KEY,
  	nickname VARCHAR(50) NOT NULL,
  	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
	CHECK (updated_at >= created_at),
	pass_hash VARCHAR(128) NOT NULL,
  	hash VARCHAR(128) DEFAULT NULL,
  	email VARCHAR(128) DEFAULT NULL
    
);

DROP TABLE IF EXISTS brands;
CREATE TABLE brands (
	id TINYINT UNSIGNED NOT NULL PRIMARY KEY,
	name VARCHAR(50) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS catalogs;

CREATE TABLE catalogs (
	id TINYINT UNSIGNED NOT NULL PRIMARY KEY,
	name VARCHAR(50) NOT NULL UNIQUE
);


DROP TABLE IF EXISTS products;

CREATE TABLE products (
  	id INT UNSIGNED NOT NULL PRIMARY KEY,
  	name VARCHAR(50) NOT NULL UNIQUE,
	description TEXT,
  	brand_name_id TINYINT UNSIGNED NOT NULL,
  	catalog_id TINYINT UNSIGNED NOT NULL,
  	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (brand_name_id) 
	REFERENCES brands(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
	FOREIGN KEY (catalog_id) 
	REFERENCES catalogs(id)
    ON UPDATE CASCADE
	ON DELETE CASCADE
);



DROP TABLE IF EXISTS main_technical_data;

CREATE TABLE main_technical_data (
  	product_id INT UNSIGNED NOT NULL,
  	volume_solid SMALLINT NOT NULL CHECK (volume_solid <= 100),
  	standard_dft SMALLINT DEFAULT NULL,
  	dry_to_touch real DEFAULT NULL,
	dry_to_handle real DEFAULT NULL,
	min_interval real,
	max_interval real DEFAULT 0,
  	treatment_tolerance BOOL DEFAULT FALSE,
  	min_temp SMALLINT,
  	max_service_temp SMALLINT,
  	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  	updated_at TIMESTAMP DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
	CHECK (updated_at >= created_at),
	FOREIGN KEY (product_id) 
	REFERENCES products(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
  
);

DROP TABLE IF EXISTS binders;

CREATE TABLE binders (
	id TINYINT UNSIGNED NOT NULL PRIMARY KEY,
	name VARCHAR(50) NOT NULL UNIQUE
	
);

DROP TABLE IF EXISTS product_binders;

CREATE TABLE product_binders (
	product_id INT UNSIGNED NOT NULL,
	binder_id  TINYINT UNSIGNED NOT NULL,
	UNIQUE (product_id, binder_id),
    FOREIGN KEY (product_id) 
	REFERENCES products(id)
    ON UPDATE CASCADE
	ON DELETE CASCADE,
	FOREIGN KEY (binder_id) 
	REFERENCES binders(id)
    ON UPDATE CASCADE
	ON DELETE CASCADE
);

DROP TABLE IF EXISTS environments;

CREATE TABLE environments (
	id TINYINT UNSIGNED NOT NULL PRIMARY KEY,
	name VARCHAR(25) NOT NULL UNIQUE
	
);

DROP TABLE IF EXISTS product_environments;
CREATE TABLE product_environments (
	product_id INT UNSIGNED NOT NULL,
	environment_id  TINYINT UNSIGNED NOT NULL,
	UNIQUE (product_id, environment_id),
	FOREIGN KEY (product_id) 
	REFERENCES products(id)
    ON UPDATE CASCADE
	ON DELETE CASCADE,
	FOREIGN KEY (environment_id) 
	REFERENCES environments(id)
    ON UPDATE CASCADE
	ON DELETE CASCADE
);


DROP TABLE IF EXISTS substrates;

CREATE TABLE substrates (
	id TINYINT UNSIGNED NOT NULL PRIMARY KEY,
	name VARCHAR(25) UNIQUE
	
);
DROP TABLE IF EXISTS product_substrates;

CREATE TABLE product_substrates (
	product_id INT UNSIGNED NOT NULL,
	substrate_id  TINYINT UNSIGNED NOT NULL,
	UNIQUE (product_id, substrate_id),
	FOREIGN KEY (product_id) 
	REFERENCES products(id)
    ON UPDATE CASCADE
	ON DELETE CASCADE,
	FOREIGN KEY (substrate_id) 
	REFERENCES substrates(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);


DROP TABLE IF EXISTS additives;

CREATE TABLE additives (
	id TINYINT UNSIGNED NOT NULL PRIMARY KEY,
	name VARCHAR(50) UNIQUE
	
);
DROP TABLE IF EXISTS product_additives;

CREATE TABLE product_additives (
	product_id INT UNSIGNED NOT NULL,
	additive_id  TINYINT UNSIGNED NOT NULL,
	UNIQUE (product_id, additive_id),
	FOREIGN KEY (product_id) 
	REFERENCES products(id)
    ON UPDATE CASCADE
	ON DELETE CASCADE,
	FOREIGN KEY (additive_id) 
	REFERENCES additives(id)
    ON UPDATE CASCADE
	ON DELETE CASCADE

);


DROP TABLE IF EXISTS resistances;

CREATE TABLE resistances (
	id TINYINT UNSIGNED NOT NULL PRIMARY KEY,
	name VARCHAR(100) UNIQUE
	
);

DROP TABLE IF EXISTS product_resistances;

CREATE TABLE product_resistances (
	product_id INT UNSIGNED NOT NULL,
	resistance_id  TINYINT UNSIGNED NOT NULL,
	UNIQUE (product_id, resistance_id),
	FOREIGN KEY (product_id) 
	REFERENCES products(id)
    ON UPDATE CASCADE
	ON DELETE CASCADE,
	FOREIGN KEY (resistance_id) 
	REFERENCES resistances(id)
    ON UPDATE CASCADE
	ON DELETE CASCADE

);

DROP TABLE IF EXISTS labs;

CREATE TABLE labs (
	id TINYINT UNSIGNED NOT NULL PRIMARY KEY,
	name VARCHAR(50) NOT NULL UNIQUE
	
);

DROP TABLE IF EXISTS pds;

CREATE TABLE pds (
	product_id INT UNSIGNED NOT NULL,
	url VARCHAR(250) NOT NULL UNIQUE,
  	FOREIGN KEY (product_id) 
  	REFERENCES products(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

DROP TABLE IF EXISTS standards;

CREATE TABLE standards (
	id INT UNSIGNED NOT NULL PRIMARY KEY,
	name VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS coating_systems;

CREATE TABLE coating_systems(
  	id INT UNSIGNED NOT NULL PRIMARY KEY,
  	primer_id INT UNSIGNED NOT NULL,
  	primer_dft TINYINT NOT NULL,
  	intermediate_id INT UNSIGNED NOT NULL,
  	intermediate_dft TINYINT NOT NULL,
  	finish_id INT UNSIGNED NOT NULL,
  	finish_dft TINYINT NOT NULL,
	FOREIGN KEY (primer_id) 
	REFERENCES products(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
	FOREIGN KEY (intermediate_id) 
	REFERENCES products(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
	FOREIGN KEY (finish_id) 
	REFERENCES products(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);	


DROP TABLE IF EXISTS approved_tests;

CREATE TABLE approved_tests (
	id INT UNSIGNED NOT NULL PRIMARY KEY,
 	lab_id TINYINT UNSIGNED NOT NULL,
  	system_id INT UNSIGNED NOT NULL,
	standard_id INT UNSIGNED NOT NULL,
  	comments TEXT DEFAULT NULL,
  	url VARCHAR(250) NOT NULL UNIQUE,
  	issued_at DATE NOT NULL,
  	expires_at DATE DEFAULT NULL,
	CHECK(expires_at >= issued_at),
	FOREIGN KEY (standard_id) 
	REFERENCES standards(id)
    ON UPDATE CASCADE
	ON DELETE CASCADE,
	FOREIGN KEY (lab_id) 
	REFERENCES labs(id)
    ON UPDATE CASCADE
	ON DELETE CASCADE,
	FOREIGN KEY (system_id) 
	REFERENCES coating_systems(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
	);
    

DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
	id INT UNSIGNED NOT NULL PRIMARY KEY,
	name VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS contractors;

CREATE TABLE contractors (
	id INT UNSIGNED NOT NULL PRIMARY KEY,
	name VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS tsr;

	
CREATE TABLE tsr (
	id TINYINT UNSIGNED NOT NULL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
  	last_name VARCHAR(50) NOT NULL,
  	email VARCHAR(120) NOT NULL UNIQUE

);

DROP TABLE IF EXISTS projects;

CREATE TABLE projects (
	id INT UNSIGNED NOT NULL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	customer_id INT UNSIGNED NOT NULL,
	contractor_id INT UNSIGNED NOT NULL,
  	comments TEXT DEFAULT NULL,
  	started_at DATE DEFAULT NULL,
  	finished_at DATE DEFAULT NULL,
	CHECK (finished_at >= started_at),
	FOREIGN KEY (customer_id) 
	REFERENCES customers(id),
	FOREIGN KEY (contractor_id) 
	REFERENCES contractors(id)
	);
    
DROP TABLE IF EXISTS reports;

CREATE TABLE reports (
	id INT UNSIGNED NOT NULL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
  	project_id INT UNSIGNED NOT NULL,
  	url VARCHAR(250) NOT NULL UNIQUE,
  	tsr_id TINYINT UNSIGNED NOT NULL,
  	started_at DATE DEFAULT NULL,
  	finished_at DATE DEFAULT NULL,
  	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	updated_at TIMESTAMP DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
	CHECK (finished_at >= started_at),
	CHECK (updated_at >= created_at),
	FOREIGN KEY (project_id) 
	REFERENCES projects(id),
	FOREIGN KEY (tsr_id) 
	REFERENCES tsr(id)
	);
    
    

DROP TABLE IF EXISTS used_systems;


CREATE TABLE used_systems(
	project_id INT UNSIGNED NOT NULL,
	used_system_id INT UNSIGNED NOT NULL,
	UNIQUE (project_id, used_system_id),
	FOREIGN KEY (used_system_id) 
	REFERENCES coating_systems(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
	FOREIGN KEY (project_id) 
	REFERENCES projects(id)
);


DROP TABLE IF EXISTS product_functions;

CREATE TABLE product_functions(
	id TINYINT UNSIGNED NOT NULL PRIMARY KEY,
	name VARCHAR(50)
);


DROP TABLE IF EXISTS prod_func_in_systems;

CREATE TABLE prod_func_in_systems(
	product_id INT UNSIGNED NOT NULL,
	function_id TINYINT UNSIGNED NOT NULL,
	FOREIGN KEY (product_id) 
	REFERENCES products(id)
    ON UPDATE CASCADE
	ON DELETE CASCADE,
	FOREIGN KEY (function_id) 
	REFERENCES product_functions(id)
    ON UPDATE CASCADE
	ON DELETE CASCADE
    
);
ALTER TABLE prod_func_in_systems ADD CONSTRAINT prod_func UNIQUE (product_id,function_id);


