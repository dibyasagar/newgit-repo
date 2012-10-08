$(document).bind
(
	"mobileinit",
	function()
	{
		$.extend
		(
			$.mobile,
			{
				ajaxEnabled:false,
				hashListeningEnabled:false,
				linkBindingEnabled:false,
				loadingMessage:false,
				pushStateEnabled:false

			}

		);

	}

);
