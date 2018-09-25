# basic-network
[Amazon Web Services 基礎からのネットワーク＆サーバー構築　改訂版](https://www.nikkeibp.co.jp/atclpubmkt/book/17/261530/)で実践したネットワーク・サーバ構成をTerraformで実現するという内容です。

# 構成要素
- [x] アジアパシフィック（東京）に設置
- [x] VPC
  - 10.1.0.0/16
  - name tag: "VPC領域：Terraform"
- [x] Internet Gateway
  - attached with VPC
- [x] Route table
  - association with public subnet
  - association with Internet Gateway
- [ ] Subnets
  - [x] public subnet
    - cidr: 10.1.1.0/24
    - name tag: "Public Subnet by Terraform"
  - [ ] private subnet
- [ ] Security group
  - [x] web security group
  - [ ] db security group
- [ ] EC2 instances
  - [x] instance for web server
    - in public subnet
    - [x] key pair for ssh
  - [ ] instance for db server
    - in private subnet

# 使い方
- Terraformをinstall

https://www.terraform.io/downloads.html

- 初期化

```bash
$ terraform init
```
- 構築

```bash
$ terraform apply
```

awsのアクセスキー・シークレットキーを入力

- 現状確認

```bash
$ terraform show
```

- 削除

```bash
$ terraform destroy
```


# 参考
## AWSについて
- [Amazon Elastic Compute Cloud:利用できるリージョン](https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-available-regions)

## Terraformについて
- [Terraform公式リファレンス：Configuration: Data Source Configuration](https://www.terraform.io/docs/configuration/data-sources.html)
- [Terraform公式リファレンス：Configuration: Resource Configuration](https://www.terraform.io/docs/configuration/resources.html)
- [Terraform公式リファレンス：Resource: AWS Provider](https://www.terraform.io/docs/providers/aws/index.html)
- [Terraform公式リファレンス：Resource: aws_vpc](https://www.terraform.io/docs/providers/aws/r/vpc.html)
- [Terraform公式リファレンス：Resource: aws_subnet](https://www.terraform.io/docs/providers/aws/r/subnet.html)
- [Terraform公式リファレンス：Resource: aws_internet_gateway](https://www.terraform.io/docs/providers/aws/r/internet_gateway.html)
- [Terraform公式リファレンス：Resource: aws_route_table](https://www.terraform.io/docs/providers/aws/r/route_table.html)
- [Terraform公式リファレンス：Resource: aws_route_table_association](https://www.terraform.io/docs/providers/aws/r/route_table_association.html)
- [Terraform公式リファレンス：Resource: aws_instance](https://www.terraform.io/docs/providers/aws/r/instance.html)
- [Terraform公式リファレンス：Resource: aws_security_group](https://www.terraform.io/docs/providers/aws/r/security_group.html)
- [Terraform公式リファレンス：getting-started#Initialization](https://www.terraform.io/intro/getting-started/build.html#initialization)
- [Terraform公式リファレンス：getting-started#ApplyChanges](https://www.terraform.io/intro/getting-started/build.html#apply-changes)
- [Hashicorp/terraform:issues#2164 How to give a single security group for an aws instance ?](https://github.com/hashicorp/terraform/issues/2164)
- [Terraform でキーペア登録し起動した EC2 に SSH接続](http://kenzo0107.hatenablog.com/entry/2017/03/27/215941)
