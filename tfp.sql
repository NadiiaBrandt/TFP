USE AdventureWorks2019
GO
---------DML TRIGGER-------------
CREATE TRIGGER notifier
	ON HumanResources.Department
		FOR 
			INSERT
			,UPDATE
		AS
		THROW 51000, 'Notification!', 1
		ROLLBACK
		;
GO
---------DDL TRIGGER-------------
CREATE TRIGGER notifier2
	ON DATABASE
		FOR 
			ALTER_TABLE
		AS
			THROW 52000, 'ALTER TABLE notification!', 1
			ROLLBACK
			;
GO

CREATE FUNCTION dbo.ufnConcatStrings (@col1 VARCHAR(50), @col2 VARCHAR(50))
RETURNS VARCHAR
	AS
	BEGIN
		RETURN ( SELECT CONCAT_WS('-', @col1, @col2 ))
	END
GO


CREATE FUNCTION HumanResources.ufnEmployeeByDepartment (@SomeID int)
RETURNS TABLE
	AS RETURN(SELECT  emp.BusinessEntityID
					  ,emp.NationalIDNumber
					  ,emp.LoginID
					  ,emp.OrganizationNode
					  ,emp.OrganizationLevel
					  ,emp.JobTitle
					  ,emp.BirthDate
					  ,emp.MaritalStatus
					  ,emp.Gender
					  ,emp.HireDate
					  ,emp.SalariedFlag
					  ,emp.VacationHours
					  ,emp.SickLeaveHours
					  ,emp.CurrentFlag
					  ,emp.rowguid
					  ,emp.ModifiedDate
				FROM HumanResources.Employee emp
			INNER JOIN HumanResources.EmployeeDepartmentHistory dep
			ON emp.BusinessEntityID = dep.BusinessEntityID
			WHERE dep.DepartmentID = @SomeID)
			;
GO

CREATE PROC Person.uspSearchByName
	@Name VARCHAR(50)
AS
BEGIN
	SELECT BusinessEntityID, FirstName, LastName
	FROM Person.Person
	WHERE FirstName LIKE '%' + @Name + '%' OR LastName LIKE '%' + @Name + '%'
END
;