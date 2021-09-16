Class School.Test Extends (%Persistent, %Library.Populate)
{

/// Description
Property testName As %String [ Required ];

Property testDetail As %String [ Required ];

Relationship teacher As School.Teacher [ Cardinality = one, Inverse = teacherTests ];

Relationship students As School.Student [ Cardinality = many, Inverse = studentTest ];

// ClassMethod create(testName As %String = "", testDetail As %String = "", teacherID As %String) As School.Test

// ClassMethod create(testName As %String = "", testDetail As %String = "", teacherClass As School.Teacher) As School.Test

ClassMethod create(testName As %String = "", testDetail As %String = "") As School.Test
{
    Set sc = $$$OK
    set test = ..%New()
    set test.testName = testName
    set test.testDetail = testDetail
    //set test.teacher = teacherClass
   // do test.teacherSetObjectId(teacherID)


    //, studentTest As School.Test
    set st = test.%Save()
    return test
}

ClassMethod GetAll() As %DynamicArray
{
    set students = []
    set sql = "SELECT * FROM School.Test"

    set data = ##class(%SQL.Statement).%ExecDirect(.stmt, sql)
    while data.%Next() {
      /*  set stud = ##class(School.Student).%OpenId(data.ID)
        set st = stud.%JSONExportToString(.coachJSONstring)
        do cars.%Push({}.%FromJSON(coachJSONstring))*/
         set obj = {
            "testName": (data.testName)
        }
        do students.%Push(obj)
    }

    return students
}

Storage Default
{
<Data name="TestDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>testName</Value>
</Value>
<Value name="3">
<Value>testDetail</Value>
</Value>
<Value name="4">
<Value>teacher</Value>
</Value>
</Data>
<DataLocation>^School.TestD</DataLocation>
<DefaultData>TestDefaultData</DefaultData>
<IdLocation>^School.TestD</IdLocation>
<IndexLocation>^School.TestI</IndexLocation>
<StreamLocation>^School.TestS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
