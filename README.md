# OCS Seeder
A simple ruby project for seamless seeding of diverse data into the OCS Inventory Server database, facilitating load and performance testing in local environment.

## Seed Software data
To seed Software Names, Publishers, and Versions, execute the following command, customizing ENV variables as needed:

```sh
ruby seeder.rb TYPE=software NAME_COUNT=10000000 BATCH_SIZE=1000
```

#### ENV variables:
**NAME_COUNT:** Number of Software Names to generate (Default: 10,000,000)
**PUBLISHER_COUNT:** Number of Software Publishers to generate (Default: NAME_COUNT / 5)
**VERSION_COUNT:** Number of Software Versions to generate (Default: NAME_COUNT / 1.25)
**BATCH_SIZE:** Batch size for data insertion (Default: 1000)
**SKIP_NAME:** Skip generating Software Names (Set to skip)
**SKIP_PUBLISHER:** Skip generating Software Publishers (Set to skip)
**SKIP_VERSION:** Skip generating Software Versions (Set to skip)

The command output provides details of the generated data, including the maximum IDs for each table before and after the execution.

```sh
ruby seeder.rb TYPE=software NAME_COUNT=10000000 BATCH_SIZE=1000
```
```
************************************************************
Generating -- 10000000 New SOFTWARE NAMES -- MAX ID: 208357
[SOFTWARE NAME] 10000000 / 10000000 DONE
10000000 New SOFTWARE NAMES Created -- MAX ID: 10208357
************************************************************


************************************************************
Generating -- 2000000 New SOFTWARE PUBLISHERS -- MAX ID: 29622
[SOFTWARE PUBLISHER] 2000000 / 2000000 DONE
2000000 New SOFTWARE PUBLISHERS Created -- MAX ID: 2029622
************************************************************


************************************************************
Generating -- 8000000 New SOFTWARE VERSIONS -- MAX ID: 77773
[SOFTWARE VERSION] 8000000 / 8000000 DONE
8000000 New SOFTWARE VERSIONS Created -- MAX ID: 8077773
************************************************************
```

Record the table ID both before and after task execution; for instance, the Software Name table IDs are 208357 before and 10208357 after. Document these values for all tables, as they will be utilized later in the process.

**NOTE:** In case gaps are introduced in primary keys, use the following command to populate missing keys:

```sh
# Make sure to configure MIN, MAX ids inside populate_missing_softwares.rb file.
ruby seeder.rb populate_missing_softwares.rb
```

## Seed Hardware data

After loading software data, generate hardware entries with the following command:

```sh
ruby seeder.rb TYPE=hardware HARDWARE_COUNT=250000 MIN_NAME_ID=208357 MAX_NAME_ID=10208357 MIN_PUBLISHER_ID=29622 MAX_PUBLISHER_ID=2029622 MIN_VERSION_ID=77773 MAX_VERSION_ID=8077773
```

#### ENV variables:
**HARDWARE_COUNT:** Number of Hardwares to generate (Default: 250,000)
**MIN_SOFTWARE_COUNT:** Minimum software installations per hardware (Default: 50)
**MAX_SOFTWARE_COUNT:** Maximum software installations per hardware (Default: 500)
**MIN_NAME_ID, MAX_NAME_ID:** Minimum and Maximum ID of Software Name to pick (Mandatory)
**MIN_PUBLISHER_ID, MAX_PUBLISHER_ID:** Minimum and Maximum ID of Software Publisher to pick (Mandatory)
**MIN_VERSION_ID, MAX_VERSION_ID:** Minimum and Maximum ID of Software Version to pick (Mandatory)

Ensure the values for MIN and MAX IDs are noted down from the software data seeding step.

**NOTE:** The tags.yml file serves to randomly choose a tag for generating hardware. Feel free to modify the file based on your specific requirements.
