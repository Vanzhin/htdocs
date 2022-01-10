
ALTER TABLE pds 
  	ADD CONSTRAINT product_id_fk
  	FOREIGN KEY (product_id) 
  	REFERENCES products(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE;
  
ALTER TABLE main_technical_data 
	ADD CONSTRAINT main_technical_data_product_id_fk
	FOREIGN KEY (product_id) 
	REFERENCES products(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE;
	
ALTER TABLE approved_tests 
	ADD CONSTRAINT standard_id_fk
	FOREIGN KEY (standard_id) 
	REFERENCES standards(id);
	
ALTER TABLE approved_tests 
	ADD CONSTRAINT lab_id_fk
	FOREIGN KEY (lab_id) 
	REFERENCES labs(id);

ALTER TABLE approved_tests 
	ADD CONSTRAINT system_id_fk
	FOREIGN KEY (system_id) 
	REFERENCES coating_systems(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE;
	

ALTER TABLE products 
	ADD CONSTRAINT brand_name_id_fk
	FOREIGN KEY (brand_name_id) 
	REFERENCES brands(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE;
	
	
ALTER TABLE products 
	ADD CONSTRAINT catalog_id_fk
	FOREIGN KEY (catalog_id) 
	REFERENCES catalogs(id);	
	
ALTER TABLE projects 
	ADD CONSTRAINT customer_id_fk
	FOREIGN KEY (customer_id) 
	REFERENCES customers(id);

ALTER TABLE projects 
	ADD CONSTRAINT contractor_id_fk
	FOREIGN KEY (contractor_id) 
	REFERENCES contractors(id);

ALTER TABLE used_systems 
	ADD CONSTRAINT used_system_id_fk
	FOREIGN KEY (used_system_id) 
	REFERENCES coating_systems(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE;	
	
ALTER TABLE used_systems 
	ADD CONSTRAINT used_systems_project_id_fk
	FOREIGN KEY (project_id) 
	REFERENCES projects(id);	

ALTER TABLE coating_systems 
	ADD CONSTRAINT primer_id_fk
	FOREIGN KEY (primer_id) 
	REFERENCES products(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE;
	
ALTER TABLE coating_systems 
	ADD CONSTRAINT intermediate_id_fk
	FOREIGN KEY (intermediate_id) 
	REFERENCES products(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE;
	
ALTER TABLE coating_systems 
	ADD CONSTRAINT finish_id_fk
	FOREIGN KEY (finish_id) 
	REFERENCES products(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE;
	
ALTER TABLE reports 
	ADD CONSTRAINT project_id_fk
	FOREIGN KEY (project_id) 
	REFERENCES projects(id);

ALTER TABLE reports 
	ADD CONSTRAINT tsr_id_fk
	FOREIGN KEY (tsr_id) 
	REFERENCES tsr(id);
	
ALTER TABLE product_binders 
	ADD CONSTRAINT binder_product_id_fk
	FOREIGN KEY (product_id) 
	REFERENCES products(id);

ALTER TABLE product_binders 
	ADD CONSTRAINT binder_id_fk
	FOREIGN KEY (binder_id) 
	REFERENCES binders(id);

ALTER TABLE prod_func_in_systems 
	ADD CONSTRAINT function_product_id_fk
	FOREIGN KEY (product_id) 
	REFERENCES products(id);

ALTER TABLE prod_func_in_systems 
	ADD CONSTRAINT function_id_fk
	FOREIGN KEY (function_id) 
	REFERENCES product_functions(id);
	
ALTER TABLE product_additives 
	ADD CONSTRAINT additives_product_id_fk
	FOREIGN KEY (product_id) 
	REFERENCES products(id);

ALTER TABLE product_additives 
	ADD CONSTRAINT additives_id_fk
	FOREIGN KEY (additive_id) 
	REFERENCES additives(id);
	
ALTER TABLE product_environments 
	ADD CONSTRAINT environment_product_id_fk
	FOREIGN KEY (product_id) 
	REFERENCES products(id);

ALTER TABLE product_environments 
	ADD CONSTRAINT environment_id_fk
	FOREIGN KEY (environment_id) 
	REFERENCES environments(id);
	
ALTER TABLE product_resistances 
	ADD CONSTRAINT resistance_product_id_fk
	FOREIGN KEY (product_id) 
	REFERENCES products(id);

ALTER TABLE product_resistances 
	ADD CONSTRAINT resistance_id_fk
	FOREIGN KEY (resistance_id) 
	REFERENCES resistances(id);	

ALTER TABLE product_substrates 
	ADD CONSTRAINT substrate_product_id_fk
	FOREIGN KEY (product_id) 
	REFERENCES products(id);

ALTER TABLE product_substrates 
	ADD CONSTRAINT substrate_id_fk
	FOREIGN KEY (substrate_id) 
	REFERENCES substrates(id);	

	