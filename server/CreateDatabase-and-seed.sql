CREATE OR REPLACE DATABASE ADCSS;
GRANT ALL ON ADCSS.* TO root@localhost;

USE ADCSS;

CREATE OR REPLACE TABLE commands
(
    id      INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    command VARCHAR(50) NOT NULL COMMENT 'The command'
) COMMENT 'bash commands';
CREATE UNIQUE INDEX UniqueCommands ON commands (command);

CREATE OR REPLACE TABLE commandLineOptions
(
    id           INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fk_idCommand INT         NOT NULL COMMENT 'Reference to the command',
    shortname    VARCHAR(1)  NOT NULL COMMENT 'The short option like -l, -p ',
    longname     VARCHAR(40) NOT NULL COMMENT 'The long option like --help, -p ',
    description  LONGTEXT    NOT NULL COMMENT 'Helptext for this options',

    CONSTRAINT FOREIGN KEY idCommand (fk_idCommand) REFERENCES commands (id) ON DELETE RESTRICT ON UPDATE RESTRICT
) COMMENT 'command line options to bash commands';

INSERT INTO commands (command)
VALUES ('ls'),
       ('find'),
       ('rm'),
       ('mkdir'),
       ('rmdir');

SELECT id into @idCommandLS
FROM commands
where command = 'ls';
INSERT INTO commandLineOptions (fk_idCommand, shortname, longname, description)
VALUES (@idCommandLS, 'h', 'human-readable', 'with -l and -s, print sizes like 1K 234M 2G etc.'),
       (@idCommandLS, 'a', 'all', 'Show all items including those beginning with .');


CREATE OR REPLACE VIEW vw_commands AS 
SELECT command, concat('-', shortname) as shortname, concat('--', longname) as longname,description
FROM commands cmd
         JOIN commandLineOptions ON fk_idCommand = cmd.id;
		 