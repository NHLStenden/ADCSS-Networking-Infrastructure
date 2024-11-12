CREATE OR REPLACE DATABASE OperatingSystems;
GRANT ALL ON OperatingSystems.* TO root@localhost;

USE OperatingSystems;

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
VALUES (@idCommandLS, 'l', '--long', 'Show more information'),
       (@idCommandLS, 'a', '-all', 'Show all items including thos beginning with .');
