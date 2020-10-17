use tiny_theaters;

LOAD DATA LOCAL INFILE 'C:\Users\Nicholas\Desktop\Dev10\tiny-theaters'
INTO TABLE excel_data
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


SHOW VARIABLES LIKE "secure_file_prive";