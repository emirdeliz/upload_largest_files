var UploadLargestFiles;
(() => {
	'use strict';
	var e = {};
	({
		885: function (e, n) {
			var t =
					(this && this.__awaiter) ||
					function (e, n, t, r) {
						return new (t || (t = Promise))(function (o, a) {
							function i(e) {
								try {
									l(r.next(e));
								} catch (e) {
									a(e);
								}
							}
							function u(e) {
								try {
									l(r.throw(e));
								} catch (e) {
									a(e);
								}
							}
							function l(e) {
								var n;
								e.done
									? o(e.value)
									: ((n = e.value),
									  n instanceof t
											? n
											: new t(function (e) {
													e(n);
											  })).then(i, u);
							}
							l((r = r.apply(e, n || [])).next());
						});
					},
				r =
					(this && this.__generator) ||
					function (e, n) {
						var t,
							r,
							o,
							a,
							i = {
								label: 0,
								sent: function () {
									if (1 & o[0]) throw o[1];
									return o[1];
								},
								trys: [],
								ops: [],
							};
						return (
							(a = { next: u(0), throw: u(1), return: u(2) }),
							'function' == typeof Symbol &&
								(a[Symbol.iterator] = function () {
									return this;
								}),
							a
						);
						function u(u) {
							return function (l) {
								return (function (u) {
									if (t) throw new TypeError('Generator is already executing.');
									for (; a && ((a = 0), u[0] && (i = 0)), i; )
										try {
											if (
												((t = 1),
												r &&
													(o =
														2 & u[0]
															? r.return
															: u[0]
															? r.throw || ((o = r.return) && o.call(r), 0)
															: r.next) &&
													!(o = o.call(r, u[1])).done)
											)
												return o;
											switch (((r = 0), o && (u = [2 & u[0], o.value]), u[0])) {
												case 0:
												case 1:
													o = u;
													break;
												case 4:
													return i.label++, { value: u[1], done: !1 };
												case 5:
													i.label++, (r = u[1]), (u = [0]);
													continue;
												case 7:
													(u = i.ops.pop()), i.trys.pop();
													continue;
												default:
													if (
														!(
															(o =
																(o = i.trys).length > 0 && o[o.length - 1]) ||
															(6 !== u[0] && 2 !== u[0])
														)
													) {
														i = 0;
														continue;
													}
													if (
														3 === u[0] &&
														(!o || (u[1] > o[0] && u[1] < o[3]))
													) {
														i.label = u[1];
														break;
													}
													if (6 === u[0] && i.label < o[1]) {
														(i.label = o[1]), (o = u);
														break;
													}
													if (o && i.label < o[2]) {
														(i.label = o[2]), i.ops.push(u);
														break;
													}
													o[2] && i.ops.pop(), i.trys.pop();
													continue;
											}
											u = n.call(e, i);
										} catch (e) {
											(u = [6, e]), (r = 0);
										} finally {
											t = o = 0;
										}
									if (5 & u[0]) throw u[1];
									return { value: u[0] ? u[1] : void 0, done: !0 };
								})([u, l]);
							};
						}
					};
			(n.__esModule = !0),
				(n.uploadFile = void 0),
				(n.uploadFile = function (e) {
					var n = e.file,
						o = e.url,
						a = e.headers,
						i = e.onProgress;
					return t(this, void 0, void 0, function () {
						var e, t;
						return r(this, function (r) {
							return (
								(e = new XMLHttpRequest()),
								i &&
									e.upload.addEventListener(
										'progress',
										function (zz) {
											i(zz);
										},
										!1
									),
								e.open('POST', o),
								a &&
									Object.keys(a || {}).forEach(function (n) {
										e.setRequestHeader(n, a[n]);
									}),
								(t = new FormData()).append('file', n),
								[
									2,
									new Promise(function (r, o) {
										try {
											e.send(t),
												(e.onloadend = function () {
													r(n);
												}),
												!e.onloadend && r(n);
										} catch (e) {
											o(e);
										}
									}),
								]
							);
						});
					});
				});
		},
	}[885](0, e),
		(UploadLargestFiles = e));
})();
