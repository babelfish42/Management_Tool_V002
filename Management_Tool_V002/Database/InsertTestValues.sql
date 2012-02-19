USE [MTDB]

INSERT INTO rights (ri_name, ri_date_inserted, ri_us_id_inserted) VALUES  ('ADMINISTRATOR',GETDATE(),1)

INSERT INTO persons (pe_type, pe_adr_id,pe_name, pe_firstname, pe_street, pe_hno, pe_zip, pe_city, pe_countryCode,pe_deleted, pe_date_inserted, pe_us_id_inserted)
VALUES  (9,2, 'Stanik','Philip','Ringwiesenstrasse','4',8600,'Dübendorf','CHE',0,getDate(),1),
        (10,1, 'Roth','Sandra','Ringwiesenstrasse','4',8600,'Dübendorf','CHE',0,getDate(),1),
        (11,1, 'Roth','Sandra','Ringwiesenstrasse','4',8600,'Dübendorf','CHE',0,getDate(),1),
        (12,3, 'Stämpfli','Thomas','ABC-Weg','1',8600,'Dübendorf','CHE',0,getDate(),1),
        (13,3, 'Zollikofer','Manuel','DEF-Strasse','4',8600,'Dübendorf','CHE',0,getDate(),1)

INSERT INTO  www (www_us_id,www_Type, www_value, www_deleted, www_date_inserted, www_us_id_inserted)
VALUES  (1, 4, 'info@roth-it.ch',0, getDate(),1),
        (1, 5, 'www.roth-it.ch',0, getDate(),1)
        
INSERT INTO dictionary (dict_name)
VALUES  ('Phone Type'),
        ('WWW Type'),
        ('Adress Type'),
        ('Contact Type'),
        ('Sex Type')
        
INSERT INTO mtdb_reference (re_dict_id,re_name, re_deleted, re_date_inserted, re_us_id_inserted)
VALUES  (1,'Phone',0,getDate(),1),
        (1,'Fax',0,getDate(),1),
        (1,'Handy',0,getDate(),1),
        (2,'E-Mail',0,getDate(),1),
        (2,'Homepage',0,getDate(),1),
        (3,'Supplier',0,getDate(),1),
        (3,'Customer',0,getDate(),1),
        (3,'Partner',0,getDate(),1),
        (4,'Technical Contact',0,getDate(),1),
        (4,'Sales Contact',0,getDate(),1),
        (4,'Support/Hotline',0,getDate(),1),
        (4,'Management Board',0,getDate(),1),
        (4,'Executive Board',0,getDate(),1),
        (5,'Woman',0,getDate(),1),
        (5,'Men',0,getDate(),1)
        
INSERT INTO phones (ph_us_id, ph_phoneType, ph_areaCode, ph_phone, ph_deleted, ph_date_inserted, ph_us_id_inserted)
VALUES  (1, 1, '+4144',8191047,0,getDate(),1),
        (1, 2, '+4144',4303808,0,getDate(),1),
        (1, 3, '+4179',4303808,0,getDate(),1)
        
INSERT INTO addresses (adr_type, adr_name, adr_street, adr_hno, adr_zip, adr_city,adr_countryCode, adr_deleted, adr_date_inserted, adr_us_id_inserted)
VALUES  (6,'Roth IT Solutions','Ringwiesenstrasse','4',8600,'Dübendorf','CHE',0,getDate(),1),
		(6,'Digitec AG','Hardstrasse','414',8000,'Zürich','CHE',0,getDate(),1),
        (7,'Stanik Informatik','Ringwiesenstrasse','4',8600,'Dübendorf','CHE',0,getDate(),1),
        (8,'Deltavista AG','Riesbachstrasse','61',8008,'Zürich','CHE',0,getDate(),1)
        

INSERT INTO  users  (us_sex, us_name,    us_firstname,     us_username, us_password, us_deleted, us_date_inserted, us_us_id_inserted)
VALUES  (1, 'Roth',     'Sandra Beatrice','sandra',     'wuschi',    0, getDate(),1),
        (2, 'Stanik',     'Philip','philip',     '1313',    0, getDate(),1)

INSERT INTO roles (ro_name, ro_date_inserted, ro_us_id_inserted) 
VALUES ('Administrator',GETDATE(),1),
		('Test User', GETDATE(),1)
		
INSERT INTO articles (ar_ag_id, ar_nr,ar_adr_id, ar_iv_id, ar_cnt, ar_name, ar_price, ar_date_inserted, ar_us_id_inserted) 
VALUES	(1,123,1,1,0,'Produkt A',99.30,GETDATE(),0),
		(2,456,1,2,0,'Produkt B',30,GETDATE(),0),
		(1,789,2,2,0,'Produkt C',13,GETDATE(),0)
	
INSERT INTO article_groups(ag_name, ag_date_inserted, ag_us_id_inserted)
VALUES	('Artikelgruppe A', GETDATE(),1)		,
		('Artikelgruppe B', GETDATE(),1)

INSERT INTO inventory_positions(iv_building, iv_date_inserted, iv_us_id_inserted)
VALUES	('Gebäude A',GETDATE(),1),
		('Gebäude ZZ', GETDATE(),1)