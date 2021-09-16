  const Students = {
   /* components: {
      store,
    },*/
    data() {
      return {
        loading: false,
        id: 5,
        students: [],
      };
    },
    computed: {
      studentID () {
          return store.state.studentID
      }
  },

    created() {
      this.loading = true;
      console.log(store.state.studentID)

      store.commit('changeID', '25');
      this.fetchStudents()
    },
    methods: {
        fetchStudents() {
          axios.get('http://localhost:9098/schoolapi/students')
              .then(response=>{
                this.loading = false
                //this.Num = response.data
                  this.students = response.data.students
              })

    },

      sentID() {

        //store.commit("changeID", 25);
      /*  var emitter = new TinyEmitter();
        emitter.emit('Student-Info','1');

      //  this.$root.$emit('Student-Info','1')*/
    },
    }

  }