output v4subnets array = [for i in range(0, 5): cidrSubnet('10.144.0.0/20', 24, i)]
