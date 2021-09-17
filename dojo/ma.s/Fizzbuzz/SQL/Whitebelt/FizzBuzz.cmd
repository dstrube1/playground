
@echo off

sqlcmd -S 10.50.0.185\DEV_SQLMAIN -U siasp -P siasp1871 -i FizzBuzz.sql

pause