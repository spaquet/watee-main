import { Controller } from "@hotwired/stimulus";
import { DirectUpload } from "@rails/activestorage";

// Connects to data-controller="image-uploader"
export default class extends Controller {
  static targets = ["input", "preview", "error_message"];
  connect() {}

  changed(event) {
    const imagesArray = Array.from(this.inputTarget.files);
    if (imagesArray.length <= 0) {
      // display error message
      this.error_messageTarget.classList.remove("hidden");
      return;
    } else {
      // Hide error message
      if (this.error_messageTarget.classList.contains("hidden")) {
        this.error_messageTarget.classList.add("hidden");
      }

      // Scan for image(s)
      const url = this.inputTarget.dataset.directUploadUrl;

      // const token = event.target.dataset.directUploadToken;
      // const attachmentName = event.target.dataset.directUploadAttachmentName;
      // if the above is uncommented, then call DirectUpload(image, url, token, attachmentName)

      imagesArray.forEach((image, index) => {
        const upload = new DirectUpload(image, url);
        upload.create((error, blob) => {
          if (error) {
            console.error(error); // TODO: replace by remote logging solution
            this.error_messageTarget.classList.remove("hidden");
            return;
          }
          this.hiddenInput().value = blob.signed_id;
          this.previewTarget.src = `${this.getURL()}/${blob.signed_id}/${
            blob.filename
          }`;
        });
      });
    }
  }

  hiddenInput() {
    if (this._hiddenInput === undefined) {
      this._hiddenInput = document.createElement("input");
      this._hiddenInput.type = "hidden";
      this._hiddenInput.name = this.inputTarget.name;
      this.inputTarget.parentNode.insertBefore(
        this._hiddenInput,
        this.inputTarget.nextSilbing
      );
    }
    return this._hiddenInput;
  }

  getURL() {
    return "/rails/active_storage/blobs/redirect";
  }
}
