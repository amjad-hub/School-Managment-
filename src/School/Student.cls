Class School.Student Extends (%Persistent, School.Worker)
{

Relationship studentTest As School.Test [ Cardinality = one, Inverse = students ];

Relationship classStudent As School.Class [ Cardinality = one, Inverse = studentsClass ];

/// Description
Property testResult As %Integer(MAXVAL = 100, MINVAL = 0);

//ClassMethod create(FirstName As %String = "", LastName As %String = "", Address As %String = "", PHNumber As %Integer = 0, studentTest As School.Test, classStudent As School.Class) As %Status

ClassMethod create(FirstName As %String = "", LastName As %String = "", Address As %String = "", PHNumber As %Integer = 0) As %Status
{
    Set sc = $$$OK
    set student = ..%New()
    set student.FirstName = FirstName
    set student.LastName = LastName
    set student.Address = Address
    set student.PHNumber = PHNumber
   /* set student.studentTest = studentTest
    set student.classStudent = classStudent*/

    //, studentTest As School.Test
    set st = student.%Save()
    return sc
}

/// Get all cars from the table
ClassMethod GetAll() As %DynamicArray
{
    set students = []
    set sql = "SELECT * FROM School.Student"

    set data = ##class(%SQL.Statement).%ExecDirect(.stmt, sql)
    while data.%Next() {
      /*  set stud = ##class(School.Student).%OpenId(data.ID)
        set st = stud.%JSONExportToString(.coachJSONstring)
        do cars.%Push({}.%FromJSON(coachJSONstring))*/
         set obj = {
            "id": (data.ID),
            "FirstName": (data.FirstName),
            "LastName": (data.LastName),
            "Address": (data.Address),
            "PHNumber": (data.PHNumber)

        }
        do students.%Push(obj)
    }

    return students
}

ClassMethod GetStudent(vID As %Integer) As %DynamicArray
{
    &sql(declare CC cursor for
         SELECT ID,FirstName,LastName,Address,PHNumber into :studentID,:first,:last,:address,:pNumber FROM School.Student WHERE (ID = :vID))
            
    &sql(open CC)
    &sql(fetch CC)
    set student = []
    While (SQLCODE=0){

        set obj = {
            "id": (studentID),
            "FirstName": (first),
            "LastName": (last),
            "Address": (address),
            "PHNumber": (pNumber)
        }
        do student.%Push(obj)
        &sql(fetch CC)
    }
    &sql(close CC)
    return student
}

ClassMethod delete(Id As %Integer) As %DynamicArray
{
    set deleteResult = ..%DeleteId(Id)
    set result = {}
    if $$$ISOK(deleteResult) set result = {"result": true}
    else  set result = {"result": false}
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(deleteResult)
    set result.message = ErrorMessage
    return result.%ToJSON()
}

Method doTest(Value As %Integer) As %Status
{
    if Value < 100 && Value > 0 {
        set ..testResult = Value
    }
    return $$$OK
}

Storage Default
{
<Data name="StudentDefaultData">
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
<Value>studentTest</Value>
</Value>
<Value name="7">
<Value>testResult</Value>
</Value>
<Value name="8">
<Value>classStudent</Value>
</Value>
</Data>
<DataLocation>^School.StudentD</DataLocation>
<DefaultData>StudentDefaultData</DefaultData>
<IdLocation>^School.StudentD</IdLocation>
<IndexLocation>^School.StudentI</IndexLocation>
<StreamLocation>^School.StudentS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
