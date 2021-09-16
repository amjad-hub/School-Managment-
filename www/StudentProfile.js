
  const StudentProfile = {

    name: 'StudentProfile',
   /* components: {
      ProductCard,
    },*/
    data() {
      return {
        id:1,
        Num:0,
        student:[],
      };
    },
    created() {
      this.loading = true;
      this.fetchStudent()
     /* .then((response) => {
        this.students = response.data.students;
        this.loading = false;
      });*/
    },
    computed: {
        studentID () {
            return store.state.studentID
        }
    },

    methods: {
        fetchStudent() {
          const ci = this.id;
          axios.get(`http://localhost:9098/schoolapi/student/${ci}`)
              .then(response=>{
                this.loading = false
                this.Num = response.data
                  this.student = response.data.student
              })

    },


    },

  };