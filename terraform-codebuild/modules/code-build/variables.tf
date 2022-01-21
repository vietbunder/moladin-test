  variable "bucket_id" {
    description = "bucket"
    type = string
    default = "" 
  }

  variable "acl" {
    description = "acl"
    type = string
    default = "" 
  }

variable "name" {
    description = "name aws codebuild"
    type = string
    default = "" 
}
variable "description" {
    description = "variable codebuild"
    type = string
    default = "" 
}
variable "build_timeout" {
    description = "timeout"
    type = string
    default = "" 
}
variable "service_role" {
    description = "service_role"
    type = string
    default = ""
}
 
variable "artifacts_type" {
    description = "artifacts"
    type = string
    default = ""
}

variable "cache_type" {
    description = "chache type"
    type = string
    default = ""
}
variable "cache_location" {
    description = "chache location"
    type = string
    default = ""
}