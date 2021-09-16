const Teachers = {
    /* components: {
       store,
     },*/
     data() {
       return {
         loading: false,
         id: 5,
         teachers: [],
       };
     },
 
     created() {
       this.loading = true;
     //  store.commit("changeID", "25");
       this.fetchTeachers()
     },
     methods: {
        fetchTeachers() {
           axios.get('http://localhost:9098/schoolapi/teachers')
               .then(response=>{
                 this.loading = false
                 //this.Num = response.data
                   this.teachers = response.data.teachers
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