
  const AddStudent = {

    data() {
      return {
        FirstName:'',
        LastName:'',
        Address:'',
        PHNumber:0,
        studentTest : [],
        classStudent : []

      };
    },

    created() {
      this.loading = true;
      this.fetchTests()
    },

    

    methods: {
        fetchTests() {
          const ci = this.id;
          axios.get(`http://localhost:9098/schoolapi/fetchTests`)
              .then(response=>{
                  this.studentTest = response.data.tests
                  this.classStudent = response.data.classes

              })
    },
    onSubmit() {
         axios({
            method: 'post',
            url: 'http://localhost:9098/schoolapi/addStudent',
            data: {
            FirstName: this.FirstName,
            LastName: this.LastName,
            Address: this.Address,
            PHNumber: this.PHNumber,
            }
        });

        
    }

    }

  };