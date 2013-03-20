'use strict';

FF.Collections.Code = Backbone.Collection.extend({
	model: FF.Models.Code,
	url: '/api/codes'
});