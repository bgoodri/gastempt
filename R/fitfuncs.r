#' Functions for gastric emptying analysis
#'
#' The \code{linexp} and the power exponential (\code{powexp}) functions are
#' useful models to fit  gastric emptying curves. The \code{linexp}
#' function can have an initial overshoot
#' to model secretion. The \code{powexp} function introduced by
#' Elashof et al. is strictlty
#' montonous declining but has more freedom to model details in the function tail.
#'
#' In Pinheiro/Bates and in the
#' @param v0 Initial volume at t=0.
#' @param t Time after meal or start of scan, in minutes; can be a vector.
#' @param tempt Emptying time constant in minutes (scalar).
#' @param logtempt Logarithm of emptying time constant in minutes (scalar).
#' @param beta Power term for power exponential function (scalar).
#' @param logbeta Logarithm of power term for power exponential function (scalar).
#' @param kappa Overshoot term for linexp function (scalar).
#' @param logkappa Logarithm of overshoot term for linexp function (scalar).
#' @return Vector of \code{length(t)} for computed volume.
#' @seealso Self starting functions  \code{\link{selfStart}}.
#' @examples
#' t = seq(0,100, by=5)
#' kappa = 1.3
#' tempt = 60
#' v0 = 400
#' beta = 3
#' par(mfrow=c(1,2))
#' plot(t, linexp(t, v0, tempt, kappa), type = "l", ylab = "volume",
#'    main = "linexp\nkappa = 1.3 and 1.0")
#' lines(t, linexp(t, v0, tempt, 1), type = "l", col = "green")
#' plot(t, powexp(t, v0, tempt, beta), type = "l", ylab = "volume",
#'   main = "powexp\nbeta = 2 and 1")
#' lines(t, powexp(t, v0, tempt, 1), type = "l", col = "green")
#' @name gastemptfunc
NULL
#' @rdname gastemptfunc
#' @export
linexp = function(t, v0 = 1, tempt, kappa){
  v0 * (1 + kappa * t / tempt) * exp(-t / tempt)
}

#' @rdname gastemptfunc
#' @export
linexp_slope = function(t, v0 = 1, tempt, kappa){
# d/dt v (1+(k t)/p) exp(-t/p)  Wolframalpha
  (v0 * exp(-t/tempt)*((kappa - 1)*tempt - kappa*t))/(tempt*tempt)
}

#' @rdname gastemptfunc
#' @export
powexp = function(t, v0 = 1, tempt, beta){
  v0 * exp(-(t / tempt) ^ beta)
}

#' @rdname gastemptfunc
#' @export
powexp_slope = function(t, v0 = 1, tempt, beta){
  # No solution for t=0
# d/dt v exp(-(t/p)^b)
#  -beta * v0 * tempt^(-beta) * t ^ (beta-1) * exp(-tempt/t)^(-beta)
  ttt = (t/tempt) ^ beta
  -(beta * v0 * exp(-ttt) * ttt)/t
}


#' @rdname gastemptfunc
#' @export
linexp_log = function(t, v0 = 1, logtempt, logkappa){
  tempt = exp(logtempt)
  v0 * (1 + exp(logkappa) * t / tempt) * exp(-t / tempt)
}

#' @rdname gastemptfunc
#' @export
powexp_log = function(t, v0 = 1, logtempt, logbeta){
  v0 * exp(-(t / exp(logtempt)) ^ exp(logbeta))
}

