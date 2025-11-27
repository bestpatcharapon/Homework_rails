import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "input",
    "preview",
    "placeholder",
    "area",
    "name",
    "size",
    "dropZone",
    "removeInput",
  ];

  connect() {
    // Optional: Add initialization logic if needed
  }

  preview(event) {
    const file = event.target.files[0];
    this.handleFile(file);
  }

  drop(event) {
    event.preventDefault();
    this.dropZoneTarget.classList.remove("border-red-500");

    if (event.dataTransfer.files && event.dataTransfer.files[0]) {
      const file = event.dataTransfer.files[0];
      this.inputTarget.files = event.dataTransfer.files;
      this.handleFile(file);
    }
  }

  dragover(event) {
    event.preventDefault();
    this.dropZoneTarget.classList.add("border-red-500");
  }

  dragleave(event) {
    event.preventDefault();
    this.dropZoneTarget.classList.remove("border-red-500");
  }

  remove(event) {
    event.preventDefault();
    this.inputTarget.value = "";
    this.areaTarget.classList.add("hidden");
    this.placeholderTarget.classList.remove("hidden");
    if (this.hasRemoveInputTarget) {
      this.removeInputTarget.value = "1";
    }
  }

  handleFile(file) {
    if (file) {
      if (this.hasRemoveInputTarget) {
        this.removeInputTarget.value = "0";
      }
      // Hide upload placeholder
      this.placeholderTarget.classList.add("hidden");

      // Show image preview
      const reader = new FileReader();
      reader.onload = (e) => {
        this.previewTarget.src = e.target.result;
        this.areaTarget.classList.remove("hidden");
      };
      reader.readAsDataURL(file);

      // Show file info
      this.nameTarget.textContent = file.name;
      const fileSizeKB = (file.size / 1024).toFixed(2);
      this.sizeTarget.textContent = `${fileSizeKB} KB`;
    }
  }
}
