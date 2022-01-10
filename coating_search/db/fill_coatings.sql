
-- AMERCOAT 182 ZP HB
INSERT INTO products (id, name, brand_name_id, catalog_id, created_at) VALUES (1, 'AMERCOAT 182 ZP HB', 1, 1, CURRENT_TIMESTAMP);

INSERT INTO main_technical_data 
(product_id, volume_solid, standard_dft, dry_to_touch, treatment_tolerance, min_temp, max_service_temp, created_at, updated_at, dry_to_handle, min_interval, max_interval) 
VALUES
(1, 55, 100,  3, false, 5, 120, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 4, 4, 0);
INSERT INTO product_binders VALUES (1,4);
INSERT INTO prod_func_in_systems VALUES (1,1), (1,2);
INSERT INTO product_environments VALUES (1,1);
INSERT INTO product_substrates VALUES (1,1);
INSERT INTO product_additives VALUES (1,2), (1,5);


-- AMERCOAT 236
INSERT INTO products (id, name, brand_name_id, catalog_id, created_at) VALUES (2, 'AMERCOAT 236', 1, 1, CURRENT_TIMESTAMP);

-- UPDATE products SET (name, brand_name_id, catalog_id, created_at) = ('AMERCOAT 236', 1, 1, CURRENT_TIMESTAMP) WHERE id =2;
INSERT INTO main_technical_data 
(product_id, volume_solid, standard_dft, dry_to_touch, treatment_tolerance, min_temp, max_service_temp, created_at, updated_at, dry_to_handle, min_interval, max_interval)
VALUES
(2, 80, 100,  4, true, -7, 120, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 8, 3, 30);

-- UPDATE main_technical_data 
-- SET (volume_solid, standard_dft, dry_to_touch, treatment_tolerance, min_temp, max_service_temp, created_at, updated_at, dry_to_handle, min_interval, max_interval) = 
-- (80, 100,  4, true, -7, 120, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 8, 3, 30) WHERE product_id = 2;
INSERT INTO product_binders VALUES (2,3);
INSERT INTO prod_func_in_systems VALUES (2,1), (2,2);
INSERT INTO product_environments VALUES (2,1), (2,2);
INSERT INTO product_substrates VALUES (2,1), (2,4);
INSERT INTO product_additives VALUES (2,2), (2,5);
INSERT INTO product_resistances VALUES (2,1), (2,3), (2,16), (2,13);


-- AMERCOAT 240
INSERT INTO products (id, name, brand_name_id, catalog_id, created_at) VALUES (3, 'AMERCOAT 240', 1, 1, CURRENT_TIMESTAMP);

INSERT INTO main_technical_data 
 (product_id, volume_solid, standard_dft, dry_to_touch, treatment_tolerance, min_temp, max_service_temp, created_at, updated_at, dry_to_handle, min_interval, max_interval)
 VALUES
(3, 87, 300,  5, true, -18, 120, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 10, 5, 90);
INSERT INTO product_binders VALUES (3,3);
INSERT INTO prod_func_in_systems VALUES (3,1), (3,2);
INSERT INTO product_environments VALUES (3,1), (3,2);
INSERT INTO product_substrates VALUES (3,1), (3,4);
INSERT INTO product_additives VALUES (3,2), (3,5);
INSERT INTO product_resistances VALUES (3,8), (3,10), (3,12), (3,16), (3,1), (3,2),(3,17);
INSERT INTO pds VALUES(3,'https://docs.td.ppgpmc.com/download/646/2541/amercoat-240--sigmacover-240');

-- AMERCOAT 385
INSERT INTO products (id, name, brand_name_id, catalog_id, created_at) VALUES (4, 'AMERCOAT 385', 1, 1, CURRENT_TIMESTAMP);

-- UPDATE products SET (name, brand_name_id, catalog_id, created_at) = ('AMERCOAT 385', 1, 1, CURRENT_TIMESTAMP) WHERE id =4;
INSERT INTO main_technical_data 
(product_id, volume_solid, standard_dft, dry_to_touch, treatment_tolerance, min_temp, max_service_temp, created_at, updated_at, dry_to_handle, min_interval, max_interval)
VALUES
(4, 68, 200,  2, true, 3, 121, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 16, 12, 30);

-- UPDATE main_technical_data 
-- SET (volume_solid, standard_dft, dry_to_touch, treatment_tolerance, min_temp, max_service_temp, created_at, updated_at, dry_to_handle, min_interval, max_interval) = 
-- (87, 300,  5, true, -18, 120, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 10, 5, 90) WHERE product_id = 3;
INSERT INTO product_binders VALUES (4,4);
INSERT INTO prod_func_in_systems VALUES (4,1), (4,2);
INSERT INTO product_environments VALUES (4,1), (4,2);
INSERT INTO product_substrates VALUES (4,1), (4,4), (4,2), (4,3);
INSERT INTO product_additives VALUES (4,2), (4,5);
INSERT INTO product_resistances VALUES (4,4);
INSERT INTO pds VALUES(4,'https://docs.td.ppgpmc.com/download/896/64213/amercoat-385');

-- AMERCOAT 391 PC
INSERT INTO products (id, name, brand_name_id, catalog_id, created_at) VALUES (5, 'AMERCOAT 391 PC', 1, 1, CURRENT_TIMESTAMP);

-- UPDATE products SET (name, brand_name_id, catalog_id, created_at) = ('AMERCOAT 385', 1, 1, CURRENT_TIMESTAMP) WHERE id =4;
INSERT INTO main_technical_data 
(product_id, volume_solid, standard_dft, dry_to_touch, treatment_tolerance, min_temp, max_service_temp, created_at, updated_at, dry_to_handle, min_interval, max_interval)
VALUES
(5, 100, 1000,  2, false, 5, 60, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 5, 4, 16);

-- UPDATE main_technical_data 
-- SET (volume_solid, standard_dft, dry_to_touch, treatment_tolerance, min_temp, max_service_temp, created_at, updated_at, dry_to_handle, min_interval, max_interval) = 
-- (87, 300,  5, true, -18, 120, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 10, 5, 90) WHERE product_id = 3;
INSERT INTO product_binders VALUES (5,1);
INSERT INTO prod_func_in_systems VALUES (5,1), (5,2);
INSERT INTO product_environments VALUES (5,2), (5,3);
INSERT INTO product_substrates VALUES (5,1), (5,2);
-- INSERT INTO product_additives VALUES (4,2), (4,5);
INSERT INTO product_resistances VALUES (5,6), (5,8), (5,10), (5,12), (5,16), (5,13), (5,9),(5,1), (5,4);
INSERT INTO pds VALUES(5,'https://docs.td.ppgpmc.com/download/21735/53409/amercoat-391-pc');


-- AMERCOAT 450 E
INSERT INTO products (id, name, brand_name_id, catalog_id, created_at) VALUES (6, 'AMERCOAT 450 E', 1, 1, CURRENT_TIMESTAMP);

-- UPDATE products SET (name, brand_name_id, catalog_id, created_at) = ('AMERCOAT 385', 1, 1, CURRENT_TIMESTAMP) WHERE id =4;
INSERT INTO main_technical_data 
(product_id, volume_solid, standard_dft, dry_to_touch, treatment_tolerance, min_temp, max_service_temp, created_at, updated_at, dry_to_handle, min_interval, max_interval)
VALUES
(6, 60, 75,  3, false, 0, 120, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 8, 8, 0);

-- UPDATE main_technical_data 
-- SET (volume_solid, standard_dft, dry_to_touch, treatment_tolerance, min_temp, max_service_temp, created_at, updated_at, dry_to_handle, min_interval, max_interval) = 
-- (87, 300,  5, true, -18, 120, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 10, 5, 90) WHERE product_id = 3;
INSERT INTO product_binders VALUES (6,8);
INSERT INTO prod_func_in_systems VALUES (6,3);
INSERT INTO product_environments VALUES (6,1);
INSERT INTO product_substrates VALUES (6,1);
-- INSERT INTO product_additives VALUES (4,2), (4,5);
INSERT INTO product_resistances VALUES (6,1);
INSERT INTO pds VALUES(6,'https://docs.td.ppgpmc.com/download/762/65526/amercoat-450-e');

-- AMERCOAT 450 S
INSERT INTO products (id, name, brand_name_id, catalog_id, created_at) VALUES (7, 'AMERCOAT 450 S', 1, 1, CURRENT_TIMESTAMP);

-- UPDATE products SET (name, brand_name_id, catalog_id, created_at) = ('AMERCOAT 385', 1, 1, CURRENT_TIMESTAMP) WHERE id =4;
INSERT INTO main_technical_data 
(product_id, volume_solid, standard_dft, dry_to_touch, treatment_tolerance, min_temp, max_service_temp, created_at, updated_at, dry_to_handle, min_interval, max_interval)
VALUES
(7, 58, 50,  1, false, 0, 120, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 4, 4, 0);

-- UPDATE main_technical_data 
-- SET (volume_solid, standard_dft, dry_to_touch, treatment_tolerance, min_temp, max_service_temp, created_at, updated_at, dry_to_handle, min_interval, max_interval) = 
-- (87, 300,  5, true, -18, 120, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 10, 5, 90) WHERE product_id = 3;
INSERT INTO product_binders VALUES (7,8);
INSERT INTO prod_func_in_systems VALUES (7,3);
INSERT INTO product_environments VALUES (7,1);
INSERT INTO product_substrates VALUES (7,1);
-- INSERT INTO product_additives VALUES (4,2), (4,5);
INSERT INTO product_resistances VALUES (7,1);
INSERT INTO pds VALUES(7,'https://docs.td.ppgpmc.com/download/827/53453/amercoat-450-s');

-- AMERCOAT 71 TC
INSERT INTO products (id, name, brand_name_id, catalog_id, created_at) VALUES (8, 'AMERCOAT 71 TC', 1, 1, CURRENT_TIMESTAMP);

-- UPDATE products SET (name, brand_name_id, catalog_id, created_at) = ('AMERCOAT 385', 1, 1, CURRENT_TIMESTAMP) WHERE id =4;
INSERT INTO main_technical_data 
(product_id, volume_solid, standard_dft, dry_to_touch, treatment_tolerance, min_temp, max_service_temp, created_at, updated_at, dry_to_handle, min_interval, max_interval)
VALUES
(8, 51, 50,  2, true, 5, 120, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 4, 4, 0);

-- UPDATE main_technical_data 
-- SET (volume_solid, standard_dft, dry_to_touch, treatment_tolerance, min_temp, max_service_temp, created_at, updated_at, dry_to_handle, min_interval, max_interval) = 
-- (87, 300,  5, true, -18, 120, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 10, 5, 90) WHERE product_id = 3;
INSERT INTO product_binders VALUES (8,4);
INSERT INTO prod_func_in_systems VALUES (8,1),(8,2);
INSERT INTO product_environments VALUES (8,1),(8,2);
INSERT INTO product_substrates VALUES (8,1),(8,3),(8,5);
-- INSERT INTO product_additives VALUES (4,2), (4,5);
INSERT INTO product_resistances VALUES (8,3);
INSERT INTO pds VALUES(8,'https://docs.td.ppgpmc.com/download/21760/64155/amercoat-71-tc');



-- AMERLOCK 400 AL
INSERT INTO products (id, name, brand_name_id, catalog_id, created_at) VALUES (9, 'AMERLOCK 400 AL', 1, 1, CURRENT_TIMESTAMP);

-- UPDATE products SET (name, brand_name_id, catalog_id, created_at) = ('AMERCOAT 385', 1, 1, CURRENT_TIMESTAMP) WHERE id =4;
INSERT INTO main_technical_data 
(product_id, volume_solid, standard_dft, dry_to_touch, treatment_tolerance, min_temp, max_service_temp, created_at, updated_at, dry_to_handle, min_interval, max_interval)
VALUES
(9, 85, 125,  6, true, 10, 120, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 24, 16, 90);

-- UPDATE main_technical_data 
-- SET (volume_solid, standard_dft, dry_to_touch, treatment_tolerance, min_temp, max_service_temp, created_at, updated_at, dry_to_handle, min_interval, max_interval) = 
-- (87, 300,  5, true, -18, 120, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 10, 5, 90) WHERE product_id = 3;
INSERT INTO product_binders VALUES (9,1);
INSERT INTO prod_func_in_systems VALUES (9,1),(9,3);
INSERT INTO product_environments VALUES (9,1),(9,2);
INSERT INTO product_substrates VALUES (9,1);
INSERT INTO product_additives VALUES (9,3);
INSERT INTO product_resistances VALUES (9,3),(9,4);
INSERT INTO pds VALUES(9,'https://docs.td.ppgpmc.com/download/21763/64688/amerlock-400-al');



-- AMERSHIELD
INSERT INTO products (id, name, brand_name_id, catalog_id, created_at) VALUES (10, 'AMERSHIELD', 1, 1, CURRENT_TIMESTAMP);

INSERT INTO main_technical_data 
 (product_id, volume_solid, standard_dft, dry_to_touch, treatment_tolerance, min_temp, max_service_temp, created_at, updated_at, dry_to_handle, min_interval, max_interval)
 VALUES 
(10, 73, 150,  0.75, false, -5, 120, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 3, 8, 4);
INSERT INTO product_binders VALUES (10,8);
INSERT INTO prod_func_in_systems VALUES (10,1),(10,3);
INSERT INTO product_environments VALUES (10,1);
INSERT INTO product_substrates VALUES (10,1),(10,2), (10,5);
-- INSERT INTO product_additives VALUES (9,3);
INSERT INTO product_resistances VALUES (10,1),(10,4);
INSERT INTO pds VALUES(10,'https://docs.td.ppgpmc.com/download/802/2381/amershield');



INSERT INTO brands VALUES(1, 'PPG'), (2, 'hempel'), (3, 'jotun'), (4, 'international');
INSERT INTO substrates VALUES (1, 'сталь'),(2, 'бетон'),(3, 'оцинковка'),(4, 'цветные металлы'), (5, 'алюминий'),(6,'дерево');
INSERT INTO binders VALUES (1, 'эпоксид'),(2, 'чистый эпоксид'), (3, 'эпоксид с феналкаминовым отверждением'),(4, 'эпоксид с амидным отверждением'), (5, 'фенол эпоксид'),(6,'полиуретан'),
(7, 'акрил'),(8, 'акрил-полиуретан'), (9, 'этилсиликат'),(10, 'силоксан'), (11, 'неорганическое керамической'),(12,'алкид'),
(13, 'каменноугольный эпоксид'),(14, 'силикон'), (15, 'противообрастающее'),(16, 'новолак'), (17, 'добавка'),(18,'винилэфир'),
(19, 'хлоркаучук'),(20, 'водная основа'), (21, 'винил'),(22, 'битум'), (23, 'фторуглеродное'),(24,'полиэфир'),(25,'фенольная смола');
INSERT INTO product_functions VALUES (1, 'грунт'),(2, 'промежуток'),(3, 'финиш'), (4, 'внутреннее покрвытие');
INSERT INTO environments VALUES (1, 'атмосфера'),(2, 'погружение в воду'),(3, 'погружение в почву');
INSERT INTO additives VALUES (1, 'GF (стеклянные чешуйки)'),(2, 'MIO (слюдистый оксид железа)'),(3, 'алюминий'), (4, 'кварцевый порошок'),(5, 'фосфат цинка'), (6, 'цинк');
INSERT INTO resistances VALUES (1, 'абразивный износ'),(2, 'авиационное топливо'), (3, 'адгезия'),(4, 'брызги и проливы химикатов'), (5, 'высокая температура'),(6,'горячая вода'),
(7, 'катодное отслаивание'),(8, 'морская вода'), (9, 'нефтепродукты'),(10, 'питьевая вода'), (11, 'под изоляцию'),(12,'пресная вода'),
(13, 'сырая нефть'),(14, 'удар'), (15, 'химикаты'),(16, 'химически загрязненная вода'), (17, 'хранение зерна'),(18,'элекстростатическая электробезопасность');
UPDATE catalogs SET name = 'бетон' WHERE id = 2;
INSERT INTO catalogs VALUES (1, 'защитные покрытия'),(2, 'морские покрытия');

DELETE FROM products WHERE id =1;
SELECT * FROM products
JOIN main_technical_data ON main_technical_data.product_id = products.id;
;