//
//  Either.swift
//  WeatherAppVIP
//
//  Created by Igor Nakonetsnoi on 26/03/2019.
//  Copyright © 2019 Igor Nakonetsnoi. All rights reserved.
//

enum Either<A, B>{
	case Left(A)
	case Right(B)
}
