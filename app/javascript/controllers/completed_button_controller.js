import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="completed-button"
export default class extends Controller {
  static targets = ["button"]
  static values = {
    updated: Boolean
  }

  connect() {
    console.log(this.updatedValue)
    
    if (this.updatedValue === true) {
      this.buttonTarget.innerText = "Marked as completed"
      this.buttonTarget.setAttribute("disabled", "true")
    }
  }

  submit() {
    console.log("form submitted")
    
    if (this.updatedValue === true) {
      console.log(this.buttonTarget)
      this.buttonTarget.innerText = "Marked as completed"
      this.buttonTarget.setAttribute("disabled", "true")
    }
  }
  
}
