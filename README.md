# OSS Bootcamp 課題2
## 課題内容
課題は以下の要件を満たすようにすることです。

- Serverspecによるテストコードが記述されていること
- Ansible playbookが[Best Practice](http://docs.ansible.com/ansible/playbooks_best_practices.html)に従っていること

このリポジトリ内にあるplaybooks以下はAnsibleのplaybookに関連するファイルが格納されています。
プロビジョニング対象に対して以下のことを行なうplaybookです。

- いわゆるELKスタックを構築する
  - ELKスタックとは Elasticsearch、Logstash、Kibana という3つのソフトウェアの頭文字をとったものです。
  - ログ収集・解析・可視化を用意に行なうことができるため、広く利用されています。
  - Elasticsearch
     - オープンソールの分散検索エンジンです。
     - 詳細は[こちら](https://www.elastic.co/jp/products/elasticsearch)をご参照ください。
  - Logstash
     - オープンソールのログ収集ツールです。
     - 詳細は[こちら](https://www.elastic.co/jp/products/logstash)をご参照ください。
  - Kibana
     - オープンソールの可視化ツールです。
     - 詳細は[こちら](https://www.elastic.co/jp/products/kibana)をご参照ください。

ELKスタックの構築をtest.yml、developemnt.yml内に全て記載しています。test.ymlとdevelopment.ymlに同じ内容が
記載されているため、修正時に2つの内容が記載されてしまっています。またplaybooks以下にファイルがすべて格納されているため、見通しも悪くなっています。そして最も最悪なことにテストが全く書かれていません。
今後このplaybookを使っていく上で問題が生じる可能性が高くなってしまっています。
そのため、Serverspecによるテストコードの記述とAnsibleのBest practiceに従った記述を行なうように修正してください。

## ディレクトリ構成

```
.
|-- README.md
|-- playbooks
|   |-- development.yml
|   |-- el_rpm
|   |-- elasticsearch.yml
|   |-- inventory
|   |-- kibana_conf.yml
|   |-- logstash_conf
|   |-- logstash_init_script
|   |-- logstash_pattern
|   |-- test.retry
|   `-- test.yml
`-- test
    |-- Rakefile
    |-- build.sh
    `-- spec
        |-- localhost
        |   `-- sample_spec.rb
        `-- spec_helper.rb
```

## テスト実行方法

test/build.sh を実行します。
Ansible の PlaybookをテストするためにDockerコンテナ(CentOS 6.9ベース)を起動して
コンテナに対してプロビジョニングし、Serverspecでそのコンテナに対してテストを実行しています。
そのため単純にrake spec を実行するとDockerコンテナが起動していない場合エラーになります。
test/build.sh ではDockerコンテナをデーモンで起動して、コンテナに対してAnsible でプロビジョニングを行った後で
rake specを実行するようになっています。
そのため、test/build.shを使用すると簡単にテストを実行できます。


## jenkinsのビルド設定

jenkinsにはすでにdockerを起動する設定が書かれているため、
JenkinsでCIするためには、test/build.shの実行をJenkinsのビルドスクリプトに記述するだけです。

## 課題への取り組み方の流れ 例

#### 1. ローカルPC(VM)へGit Clone

```
git clone http://devops01.jp.oracle.com/gitlab/htamakos/devops_task2.git
```

#### 2. テストを実行する

```
$ sh test/build.sh
```

#### 3. テストの失敗内容を確認

#### 4. インフラコード(playbooksディレクトリ以下)を確認・修正

1. ブランチを作成
2. ファイルを修正

#### 5. テストを実行して成功することを確認

```
$ sh test/build.sh
```

#### 6. コミットしてpushする

```
$ git commit -am "FIX: xxxxxx"
$ git push origin fix-xxxxx-branch
```

#### 7. Gitlab上でMerge Request を作成する
