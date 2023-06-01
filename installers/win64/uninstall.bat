@echo off

@rem Deleting multirun directory:
if exist %cd% (
	rmdir %cd% /s /q
)

@rem Uninstallition completed. :)
