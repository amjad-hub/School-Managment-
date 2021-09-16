Class School.Teacher Extends (%Persistent, School.Worker)
{

/// Description
Property Salary As %Integer [ Required ];

Relationship teacherTests As School.Test [ Cardinality = many, Inverse = teacher ];

ClassMethod create(FirstName As %String = "", LastName As %String = 0, Address As %String = "", PHNumber As %Integer = "", Salary As %Integer = "") As School.Teacher
{
    Set sc = $$$OK
    set teacher = ..%New()
    set teacher.FirstName = FirstName
    set teacher.LastName = LastName
    set teacher.Address = Address
    set teacher.PHNumber = PHNumber
    set teacher.Salary = Salary

    set st = teacher.%Save()
    return teacher
}

ClassMethod GetAll() As %DynamicArray
{

    set teachers = []
    set sql = "SELECT * FROM School.Teacher"

    set data = ##class(%SQL.Statement).%ExecDirect(.stmt, sql)
    while data.%Next() {
        set obj = {
            "id": (data.ID),
            "FirstName": (data.FirstName),
            "LastName": (data.LastName),
            "Address": (data.Address),
            "PHNumber": (data.PHNumber),
            "Salary": (data.Salary)
        }
        do teachers.%Push(obj)
    }
    return teachers
}

ClassMethod delete(Id As %String = "") As %DynamicArray
{
    set deleteResult = ..%DeleteId(Id)
    set result = {}
    if $$$ISOK(deleteResult) set result = {"result": true}
    else  set result = {"result": false}
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(deleteResult)
    set result.message = ErrorMessage
    return result.%ToJSON()
}

Method writeTest(testName As %String = "", testDetail As %String = "") As %Status
{

    Set sc = $$$OK
    set test = ##class(School.Test).%New()
    set test.teacher = $this
    set test.testName = testName
    set test.testDetail = testDetail
    
    set st = test.%Save()
    return st
}

Storage Default
{
<Data name="TeacherDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>FirstName</Value>
</Value>
<Value name="3">
<Value>LastName</Value>
</Value>
<Value name="4">
<Value>Address</Value>
</Value>
<Value name="5">
<Value>PHNumber</Value>
</Value>
<Value name="6">
<Value>Salary</Value>
</Value>
</Data>
<DataLocation>^School.TeacherD</DataLocation>
<DefaultData>TeacherDefaultData</DefaultData>
<IdLocation>^School.TeacherD</IdLocation>
<IndexLocation>^School.TeacherI</IndexLocation>
<StreamLocation>^School.TeacherS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
