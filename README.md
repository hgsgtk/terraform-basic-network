# basic-network
[Amazon Web Services 基礎からのネットワーク＆サーバー構築　改訂版](https://www.nikkeibp.co.jp/atclpubmkt/book/17/261530/)で実践したネットワーク・サーバ構成をTerraformで実現するという内容です。

# 構成要素
- [x] アジアパシフィック（東京）に設置
- [x] VPC
  - 10.1.0.0/16
  - name tag: "VPC領域：Terraform"
- [ ] Subnets
  - [ ] public subnet
  - [ ] private subnet
- EC2 instances
  - [ ] instance for web server
    - in public subnet
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
- [Terraform公式リファレンス：AWS Provider](https://www.terraform.io/docs/providers/aws/index.html)
- [Terraform公式リファレンス：aws_vpc](https://www.terraform.io/docs/providers/aws/r/vpc.html)
- [Terraform公式リファレンス：getting-started#Initialization](https://www.terraform.io/intro/getting-started/build.html#initialization)
- [Terraform公式リファレンス：getting-started#ApplyChanges](https://www.terraform.io/intro/getting-started/build.html#apply-changes)
