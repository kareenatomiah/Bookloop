import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

eagerLoadControllersFrom("controllers", application)
import WebcamController from "./webcam_controller"
application.register("webcam", WebcamController)
