locals {
    bucket_id = "example"
    acl    = "private"
    name          = "test-project"
    description   = "test_codebuild_project"
    build_timeout = "5"
    service_role  = "aws_iam_role.example.arn"
    artifacts_type = "NO_ARTIFACTS"
    chache_type     = "S3"
    chache_location = "aws_s3_bucket.example.bucket"
}

module "cb_development_jojo" {
    source = "../../modules/code-build"
    bucket_id = local.bucket_id
    acl = local.acl
    name          = local.name
    description   = local.description
    build_timeout = local.build_timeout
    service_role  = local.service_role
    artifacts_type = local.artifacts_type
    cache_type     = "S3"
    cache_location = local.chache_location

    
}