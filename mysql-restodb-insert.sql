START TRANSACTION;

DELETE FROM restodb.customers;

INSERT INTO restodb.customers
  (id,customer_first_name,customer_last_name,gender_cd,customer_address,customer_email_address,customer_phone_number)
VALUES
  ('1000','Abigail','Hernandez','2','82-5 Una Vallis','abigail.h@example.com','XXX-974-5439'),
  ('1001','Alexander','Anderson','1','287-3 Durius Valles','alexander.a@example.com','XXX-400-5392'),
  ('1002','Amanda','Johnson','2','282-4 Utopia Planitia','amanda.j@example.com','XXX-272-1262'),
  ('1003','Amelia','Jones','2','166-2 Tinto Vallis','amelia.j@example.com','XXX-012-1324'),
  ('1004','Aria','Brown','2','152-5 Centauri Montes','aria.b@example.com','XXX-726-9363'),
  ('1005','Ashley','Martin','2','299-8 Bosporos Planum','ashley.m@example.com','XXX-831-6906'),
  ('1006','Aurora','Davis','2','103-3 Axius Valles','aurora.d@example.com','XXX-408-5878'),
  ('1007','Ava','Martinez','2','82-12 Amazonis Planitia','ava.m@example.com','XXX-004-9396'),
  ('1008','Avery','Miller','2','27-5 Ascuris Planum','avery.m@example.com','XXX-931-5474'),
  ('1009','Benjamin','Garcia','1','66-14 Elysium Planitia','benjamin.g@example.com','XXX-973-2509'),
  ('1010','Camila','Moore','2','228-2 Coronae Planum','camila.m@example.com','XXX-940-8850'),
  ('1011','Charles','Hernandez','1','81-15 Chalce Montes','charles.h@example.com','XXX-061-2330'),
  ('1012','Charlotte','Rodriguez','2','180-17 Grjota Valles','charlotte.r@example.com','XXX-231-3945'),
  ('1013','Chloe','Johnson','2','49-12 Isidis Planitia','chloe.j@example.com','XXX-836-3865'),
  ('1014','Daniel','Jones','1','250-11 Padus Vallis','daniel.j@example.com','XXX-445-4642'),
  ('1015','David','Martin','1','189-9 Locras Valles','david.m@example.com','XXX-943-8793'),
  ('1016','Dorothy','Smith','2','65-13 Termes Vallis','dorothy.s@example.com','XXX-765-1408'),
  ('1017','Eleanor','Taylor','2','45-2 Verde Vallis','eleanor.t@example.com','XXX-218-4796'),
  ('1018','Elijah','Martinez','1','99-4 Hibes Montes','elijah.m@example.com','XXX-655-5712'),
  ('1019','Elizabeth','Thompson','2','232-9 Moa Valles','elizabeth.t@example.com','XXX-624-3348'),
  ('1020','Ella','White','2','80 Argentea Planum','ella.w@example.com','XXX-946-0791'),
  ('1021','Ellie','Miller','2','34-5 Runa Vallis','ellie.m@example.com','XXX-510-3581'),
  ('1022','Emma','Wilson','2','238-10 Chryse Planitia','emma.w@example.com','XXX-043-5557'),
  ('1023','Ethan','Moore','1','93-11 Granicus Valles','ethan.m@example.com','XXX-060-4077'),
  ('1024','Evelyn','Anderson','2','173-11 Hibes Montes','evelyn.a@example.com','XXX-236-4207'),
  ('1025','George','Rodriguez','1','151-16 Argyre Planitia','george.r@example.com','XXX-319-3969'),
  ('1026','Gianna','Brown','2','282-9 Frento Vallis','gianna.b@example.com','XXX-869-2508'),
  ('1027','Harper','Davis','1','249-7 Louros Valles','harper.d@example.com','XXX-941-9649'),
  ('1028','Harry','Garcia','1','236-5 Euripus Mons','harry.g@example.com','XXX-667-3862'),
  ('1029','Henry','Smith','1','204-18 Asopus Vallis','henry.s@example.com','XXX-313-2708'),
  ('1030','Isabella','Hernandez','2','176-6 Ascraeus Mons','isabella.h@example.com','XXX-356-7828'),
  ('1031','Jack','Taylor','1','100-12 Stura Vallis','jack.t@example.com','XXX-738-3754'),
  ('1032','Jackson','Thompson','1','70-11 Gonnus Mons','jackson.t@example.com','XXX-803-6422'),
  ('1033','Jacob','Johnson','1','43-17 Syria Mons','jacob.j@example.com','XXX-189-0415'),
  ('1034','James','White','1','83-18 Nepenthes Planum','james.w@example.com','XXX-797-9810'),
  ('1035','Jennifer','Jones','2','107-17 Labou Vallis','jennifer.j@example.com','XXX-916-5657'),
  ('1036','Jessica','Martin','2','223-2 Vedra Valles','jessica.m@example.com','XXX-104-5481'),
  ('1037','John','Smith','1','10-18 Geryon Montes','john.s@example.com','XXX-741-9881'),
  ('1038','John','Wilson','1','297-14 Eridania Planitia','john.w@example.com','XXX-789-8825'),
  ('1039','Joseph','Martinez','1','173-16 Mawrth Vallis','joseph.m@example.com','XXX-435-0920'),
  ('1040','Layla','Anderson','2','271-19 Matrona Vallis','layla.a@example.com','XXX-551-5120'),
  ('1041','Levi','Brown','2','293-8 Charitum Montes','levi.b@example.com','XXX-668-3943'),
  ('1042','Liam','Davis','1','135-1 Hermus Vallis','liam.d@example.com','XXX-526-3448'),
  ('1043','Lily','Garcia','2','185-11 Tisia Valles','lily.g@example.com','XXX-724-8856'),
  ('1044','Lucas','Hernandez','1','252-9 Al-Qahira Vallis','lucas.h@example.com','XXX-904-1818'),
  ('1045','Luna','Miller','2','294-17 Elaver Vallis','luna.m@example.com','XXX-044-9533'),
  ('1046','Madison','Johnson','1','143 Argyre Mons','madison.j@example.com','XXX-761-2628'),
  ('1047','Margaret','Moore','2','187-5 Hadriacus Mons','margaret.m@example.com','XXX-436-6463'),
  ('1048','Mary','Rodriguez','2','29-5 Mamers Valles','mary.r@example.com','XXX-467-6161'),
  ('1049','Mason','Jones','1','225-1 Maumee Valles','mason.j@example.com','XXX-837-9065'),
  ('1050','Mateo','Martin','1','226-14 Amazonis Planitia','mateo.m@example.com','XXX-779-8138'),
  ('1051','Mia','Smith','2','191-9 Ravi Vallis','mia.s@example.com','XXX-381-2595'),
  ('1052','Michael','Martinez','1','25-7 Melas Chasma','michael.m@example.com','XXX-517-2065'),
  ('1053','Mila','Miller','2','96-7 Dittaino Valles','mila.m@example.com','XXX-323-5217'),
  ('1054','Noah','Moore','1','283-18 Huo Hsing','noah.m@example.com','XXX-803-6548'),
  ('1055','Oliver','Rodriguez','1','35-3 Amenthes Planum','oliver.r@example.com','XXX-195-1135'),
  ('1056','Olivia','Taylor','2','170-9 Hadriacus Mons','olivia.t@example.com','XXX-318-8536'),
  ('1057','Penelope','Smith','2','296-19 Peraea Mons','penelope.s@example.com','XXX-926-3165'),
  ('1058','Peter','Taylor','1','144-11 Oltis Valles','peter.t@example.com','XXX-778-9761'),
  ('1059','Richard','Thompson','1','187-2 Ascuris Planum','richard.t@example.com','XXX-882-6751'),
  ('1060','Robert','Thompson','1','67-1 Ravi Vallis','robert.t@example.com','XXX-672-1523'),
  ('1061','Sarah','White','2','242-3 Geryon Montes','sarah.w@example.com','XXX-800-7705'),
  ('1062','Scarlett','Wilson','2','190-19 Tharsis Montes','scarlett.w@example.com','XXX-174-5337'),
  ('1063','Sebastian','White','1','32-19 Uzboi Vallis','sebastian.w@example.com','XXX-193-6542'),
  ('1064','Sofia','Wilson','2','203-3 Her Desher','sofia.w@example.com','XXX-311-2539'),
  ('1065','Sophia','Anderson','2','13-5 Eos Chasma','sophia.a@example.com','XXX-726-6132'),
  ('1066','Susan','Brown','2','143-7 Harmakhis Vallis','susan.b@example.com','XXX-565-6562'),
  ('1067','Theodore','Anderson','1','17-13 Clanis Valles','theodore.a@example.com','XXX-131-9087'),
  ('1068','Thomas','Brown','1','103-12 Ganges Chasma','thomas.b@example.com','XXX-308-9216'),
  ('1069','Victoria','Davis','2','244-12 Charitum Montes','victoria.d@example.com','XXX-254-3188'),
  ('1070','William','Garcia','1','56-12 Hypsas Vallis','william.g@example.com','XXX-416-6645')
;

DELETE FROM restodb.gates;

INSERT INTO restodb.gates
  (id,gate_name,gate_type_cd)
VALUES
  ('1001','店舗 入口','2'),
  ('1002','店舗 出口','5'),
  ('1003','フロア 入口','2'),
  ('1004','フロア 出口','5'),
  ('1005','スタッフ通用口 入口','1'),
  ('1006','スタッフ通用口 出口','5'),
  ('1007','配達通用口 入口','1'),
  ('1008','配達通用口 出口','4')
;

DELETE FROM restodb.menus;

INSERT INTO restodb.menus
  (id,menu_name,menu_type_cd,provide_cd,menu_price,menu_overview)
VALUES
  ('1001','Margherita','1','1','10',''),
  ('1002','Marinara','1','1','10',''),
  ('1003','Quattro Formaggi','1','1','10',''),
  ('1004','Boscaiola','1','1','10',''),
  ('1005','Siciliana','1','1','10',''),
  ('1006','Pescatore','1','1','10',''),
  ('1007','Genovese','1','1','10',''),
  ('1008','Green tea','2','1','1',''),
  ('1009','Black tea','2','1','1',''),
  ('1010','Coffee','2','1','1',''),
  ('1011','Coke','2','1','1',''),
  ('1012','Beer','2','1','1',''),
  ('1013','Oolong tea','2','1','1',''),
  ('1014','Ginger ale','2','1','1',''),
  ('1015','Chicken wings','2','1','1',''),
  ('1016','Garlic bread','2','1','1',''),
  ('1017','Fries','2','1','1',''),
  ('1018','Pepperoni','3','1','1',''),
  ('1019','Mushrooms','3','1','1',''),
  ('1020','Bell peppers','3','1','1',''),
  ('1021','Onions','3','1','1',''),
  ('1022','Olives','3','1','1',''),
  ('1023','Sausage','3','1','1',''),
  ('1024','Monterey Jack cheese','3','1','1',''),
  ('1025','Cheddar cheese','3','1','1',''),
  ('1026','Tomatoes','3','1','1',''),
  ('1027','Bacon','3','1','1','')
;

DELETE FROM restodb.products;

INSERT INTO restodb.products
  (id,product_name,provide_cd,product_overview)
VALUES
  ('1001','Margherita','1',''),
  ('1002','Marinara','1',''),
  ('1003','Quattro Formaggi','1',''),
  ('1004','Boscaiola','1',''),
  ('1005','Siciliana','1',''),
  ('1006','Pescatore','1',''),
  ('1007','Genovese','1',''),
  ('1008','Green tea','2',''),
  ('1009','Black tea','2',''),
  ('1010','Coffee','2',''),
  ('1011','Coke','2',''),
  ('1012','Beer','2',''),
  ('1013','Oolong tea','2',''),
  ('1014','Ginger ale','2',''),
  ('1015','Chicken wings','2',''),
  ('1016','Garlic bread','2',''),
  ('1017','Fries','2',''),
  ('1018','Pepperoni','3',''),
  ('1019','Mushrooms','3',''),
  ('1020','Bell peppers','3',''),
  ('1021','Onions','3',''),
  ('1022','Olives','3',''),
  ('1023','Sausage','3',''),
  ('1024','Monterey Jack cheese','3',''),
  ('1025','Cheddar cheese','3',''),
  ('1026','Tomatoes','3',''),
  ('1027','Bacon','3','')
;

DELETE FROM restodb.rolls;

INSERT INTO restodb.rolls
  (id,roll_name)
VALUES
  ('1001','店長'),
  ('1002','管理'),
  ('1003','調理'),
  ('1004','接客'),
  ('1005','配達')
;

DELETE FROM restodb.seats;

INSERT INTO restodb.seats
  (id,seet_name,seat_type_cd,seet_count,seat_comment)
VALUES
  ('1001','counter','1','12',''),
  ('1002','table-A','2','4',''),
  ('1003','table-B','2','4',''),
  ('1004','table-C','2','4',''),
  ('1005','table-D','2','4',''),
  ('1006','table-E','2','4','terrace'),
  ('1007','table-F','2','4','terrace'),
  ('1008','booth-A','3','4',''),
  ('1009','booth-B','3','4',''),
  ('1010','booth-C','3','4','')
;

DELETE FROM restodb.staffs;

INSERT INTO restodb.staffs
  (id,contract_type_cd,staff_first_name,staff_last_name,gender_cd,staff_address,staff_email_address,staff_phone_number)
VALUES
  ('1000','1','John','Smith','1','10-18 Geryon Montes','john.s@example.com','XXX-741-9881'),
  ('1001','2','William','Garcia','1','56-12 Hypsas Vallis','william.g@example.com','XXX-416-6645'),
  ('1002','2','Liam','Davis','1','135-1 Hermus Vallis','liam.d@example.com','XXX-526-3448'),
  ('1003','2','Harper','Davis','1','249-7 Louros Valles','harper.d@example.com','XXX-941-9649'),
  ('1004','2','Mia','Smith','2','191-9 Ravi Vallis','mia.s@example.com','XXX-381-2595'),
  ('1005','5','Sarah','White','2','242-3 Geryon Montes','sarah.w@example.com','XXX-800-7705'),
  ('1006','5','Eleanor','Taylor','2','45-2 Verde Vallis','eleanor.t@example.com','XXX-218-4796'),
  ('1007','5','Sarah','White','2','242-3 Geryon Montes','sarah.w@example.com','XXX-800-7705'),
  ('1008','2','Ethan','Moore','1','93-11 Granicus Valles','ethan.m@example.com','XXX-060-4077'),
  ('1009','5','Charles','Hernandez','1','81-15 Chalce Montes','charles.h@example.com','XXX-061-2330'),
  ('1010','5','Henry','Smith','1','204-18 Asopus Vallis','henry.s@example.com','XXX-313-2708'),
  ('1011','5','Mason','Jones','1','225-1 Maumee Valles','mason.j@example.com','XXX-837-9065'),
  ('1012','5','Harry','Garcia','1','236-5 Euripus Mons','harry.g@example.com','XXX-667-3862'),
  ('1013','5','Levi','Brown','2','293-8 Charitum Montes','levi.b@example.com','XXX-668-3943')
;

COMMIT;

