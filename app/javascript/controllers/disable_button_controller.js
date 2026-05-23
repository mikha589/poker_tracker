import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["submit"]

    disable(event) {
        setTimeout(() => {
            if (this.hasSubmitTarget) {
                this.submitTarget.disabled = true

                this.submitTarget.value = "Ожидайте завершения..."

                this.submitTarget.classList.add("opacity-50", "cursor-not-allowed")

                this.submitTarget.classList.remove("hover:bg-slate-700", "cursor-pointer", "active:scale-95")
            }
        }, 50)
    }
}