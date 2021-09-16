
  const DoTest = {

    data() {
      return {
        testName:'',
        testDetail:'',


      };
    },

    created() {
      this.loading = true;
    },


    methods: {
    onSubmit() {
         axios({
            method: 'post',
            url: 'http://localhost:9098/schoolapi/doTest',
            data: {
            testDetail: this.testDetail,
            testName: this.testName,
            }
        });

        
    }

    }

  };