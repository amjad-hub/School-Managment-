app.component('product-display', {
    template: 
      /*html*/ 
      `<div class="product-display">
      <div class="product-container">
        <div class="product-info">
  
  

          
          <button 
            class="button" 
            v-on:click="setID">
            Add to Cart
          </button>
        </div>
      </div>
    </div>`,
data() {
    return {
        studentID: student.ID

    }
  },
  methods: {
    setID() {
       // this.cart += 1
        store.commit('changeID', this.studentID);

    },
  }
  })