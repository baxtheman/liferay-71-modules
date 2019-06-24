console.log('load theme-js-error');

window.onerror = function(msg, url, lineNo, columnNo, error) {
	A=AUI();
	try {
		var errnode = A.Node.create('<code/>');
		errnode.addClass('small');
		errnode.addClass('text-danger');
		errnode.setStyle('display','block');
		errnode.text('ERROR: ' + JSON.stringify(msg) + ', ' + error);

		A.one('#content').append(errnode);
	} catch (err) {
		console.error(err);
	}
};

window.addEventListener("unhandledrejection", function(err, promise) {
	// handle error here, for example log
	console.log('unhandledrejection occured: ' + err);
	window.onerror.apply(this, arguments); // call
	event.preventDefault();
});

window.__fireError__  = function() {

	setTimeout(() => {
		window.__undefined__.__undefined__;
	}, 2000);
}
