db_instances = {
    mysql={
        ami          =   "ami-0220d79f3f480ecf5"
        instance_type=  "t3.micro"
    }
    rabbitmq={
        ami          =   "ami-0220d79f3f480ecf5"
        instance_type=  "t3.micro"
    }
    mongodb={
        ami          =   "ami-0220d79f3f480ecf5"
        instance_type=  "t3.micro"
    }
    redis={
        ami          =   "ami-0220d79f3f480ecf5"
        instance_type=  "t3.micro"
    }
    # frontend= {
    #     ami          =   "ami-0220d79f3f480ecf5"
    #     instance_type=  "t3.micro"
    # }
    # catalogue={
    #     ami          =   "ami-0220d79f3f480ecf5"
    #     instance_type=  "t3.micro"
    # }
    
    # cart={
    #     ami          =   "ami-0220d79f3f480ecf5"
    #     instance_type=  "t3.micro"
    # }
    # user={
    #     ami          =   "ami-0220d79f3f480ecf5"
    #     instance_type=  "t3.micro"
    # }
    # shipping={
    #     ami          =   "ami-0220d79f3f480ecf5"
    #     instance_type=  "t3.micro"
    # }
   
    # payment={
    #     ami          =   "ami-0220d79f3f480ecf5"
    #     instance_type=  "t3.micro"
    # }
  }

zone_id = "Z059118438CVE8ZE5ZI6Q"
vpc_security_group_ids = ["sg-039813d39262650f5"]
env="dev"

eks = {
    main= {
    subnets= ["subnet-039da80d8264e0a4d","subnet-05fe51d21afe293ad"]
    eks_version= 1.32
    node_groups={
        main= {
            min_nodes=1
            max_nodes=2
        }
    }
    }
}