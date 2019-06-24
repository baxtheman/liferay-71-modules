console.log('load theme-autorefresh');

AUI().use(['aui-base','liferay-store'], function() {

	var A = AUI();
	var __timer;
	var __autorefresh_val = '__autorefresh_val';

	var _setupAutoRefresh = function() {

		if (!Liferay.ThemeDisplay.isSignedIn()) return;

		var nav = A.one('#navigationCollapse');
		if (!nav) return;
		if (A.one('#autorefresh-app')) return;

		var app = A.Node.create(`
			<div class="dropdown show" id="autorefresh-app">
				<a class="btn btn-link btn-sm dropdown-toggle"
					href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false" title="Ricaricamento completo della pagina">
					[Page autorefresh]
				</a>

				<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
					<a class="dropdown-item" href="#" data-value=0>OFF</a>
					<a class="dropdown-item" href="#" data-value=5>5 secs</a>
					<a class="dropdown-item" href="#" data-value=15>15 secs</a>
					<a class="dropdown-item" href="#" data-value=30>30 secs</a>
					<a class="dropdown-item" href="#" data-value=60>1 min</a>
					<a class="dropdown-item" href="#" data-value=120>2 min</a>
				</div>
			</div>
		`);


		nav.append(app);

		var _app = A.one('#autorefresh-app');

		_app.delegate('click',
			function(e) {
				e.preventDefault();
				var btn = e.currentTarget;
				var val = parseInt(btn.getData('value'));

				Liferay.Store.set(__autorefresh_val, val);

				_feedback(_app,val);
		},'.dropdown-menu a');

		Liferay.Store.get(__autorefresh_val, function(val) {
			_feedback(_app,val);
		});

		console.log('theme-autorefresh / setup autorefresh');
	};

	var _feedback = function(_app,val) {

		var btn = _app.one('.btn');
		btn.all('span').remove();

		_app.all('.dropdown-item').removeClass('active');

		if (btn && val > 0) {

			btn.append(A.Node.create('<span class="icon-plus icon-spin"></span>'));

			_app.one('.dropdown-item[data-value="'+val+'"]').toggleClass('active');

			_setupInterval(val);
		}
	}

	var _setupInterval = function(val) {
		console.debug("theme-autorefresh / change to " + val);
		clearInterval(__timer);

		var move = false;
		A.one(document).once('mousemove', function(e) {
			move=true;
		});

		if (val == 0) return;

		__timer = setInterval(function() {

			if (!move) {
				Liferay.Util.navigate(window.location.href);
			} else {
				console.log("theme-autorefresh / skip...");
			}

			move=false;
			A.one(document).once('mousemove', function(e) {
				move=true;
			});

		}, val * 1000);
	}

	var _resetInterval = function() {

		clearInterval(__timer);

		var _app = A.one('#autorefresh-app');
		_feedback(_app,0);
	}

	_setupAutoRefresh();

	Liferay.on('startNavigate', function() {

		clearInterval(__timer);
	});

	Liferay.on('endNavigate', function(event) {

		_setupAutoRefresh();
	});
})

