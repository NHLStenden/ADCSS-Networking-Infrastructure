SELECT command, concat('-', shortname), concat('--', longname),description
FROM commands cmd
         JOIN commandLineOptions ON fk_idCommand = cmd.id;