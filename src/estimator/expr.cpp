
#include <estimator/expr.hpp>


expr::lptr expr::lor(expr::lptr a, expr::lptr b) {
	expr::lptr r;

	if (a->t_lor(r, b))
		return r;
	if (b->t_lor(r, a))
		return r;

	return std::make_shared<const struct expr::loring>(a, b);
}

expr::lptr expr::land(expr::lptr a, expr::lptr b) {
	expr::lptr r;

	if (a->t_land(r, b))
		return r;
	if (b->t_land(r, a))
		return r;

	return std::make_shared<const struct expr::landing>(a, b);
}

