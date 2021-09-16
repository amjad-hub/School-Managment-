// store/index.js
 
const store = new Vuex.Store({
  state: {
    studentID: '18'
  },
 /* mutations: {
  	increment: state => state.count++,
    decrement: state => state.count--
  }*/

  mutations: {
    changeID (state, newID) {
      state.studentID = newID
    }
 },
})