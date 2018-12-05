(() => {
  const application = Stimulus.Application.start()

  application.register("hello", class extends Stimulus.Controller {
    static get targets() {
      return [ "fullname" ]
    }

    edit(){
      const element = this.fullnameTarget.value
      console.log(element)
    }

  })
})()