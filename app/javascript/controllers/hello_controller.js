import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Hello World!");
  }
  preview() {
    console.log("Preview!");
  }
  alert(event) {
    alert("Hello Preview");
  }
}
