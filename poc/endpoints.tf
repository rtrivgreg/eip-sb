resource "aws_vpc_endpoint" "s3" {
  count = local.profile.enable_s3_endpoint ? 1 : 0

  vpc_id            = module.poc_vpc.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = concat(
    module.poc_vpc.public_route_table_ids,
    module.poc_vpc.private_route_table_ids
  )

  tags = merge(local.common_tags, {
    Name = "${local.profile.name}-s3-endpoint"
  })
}

resource "aws_vpc_endpoint" "dynamodb" {
  count = local.profile.enable_dynamodb_endpoint ? 1 : 0

  vpc_id            = module.poc_vpc.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.dynamodb"
  vpc_endpoint_type = "Gateway"

  route_table_ids = concat(
    module.poc_vpc.public_route_table_ids,
    module.poc_vpc.private_route_table_ids
  )

  tags = merge(local.common_tags, {
    Name = "${local.profile.name}-dynamodb-endpoint"
  })
}
