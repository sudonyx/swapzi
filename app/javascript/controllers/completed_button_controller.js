import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="completed-button"

export default class extends Controller {
  static targets = ["button"]
  static values = {
    updated: { type: Boolean, default: false }
  }

  connect() {
    console.log("connected")
    console.log(this.updatedValue)
    
    if (this.updatedValue === true) {
      this.buttonTarget.innerText = "Marked as completed"
      this.buttonTarget.setAttribute("disabled", "true")
    }
  }

  submit() {
    console.log("form submitted")
    console.log(this.updatedValue)

    if (this.updatedValue === true) {
      this.buttonTarget.innerText = "Marked as completed"
      this.buttonTarget.setAttribute("disabled", "true")
    }
  }
}
