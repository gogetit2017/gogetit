!function (window, document, jQuery, undefined) {
    function merge(obj) {
        for (var i = 1; i < arguments.length; i++) {
            var def = arguments[i]
            for (var n in def) {
                if (obj[n] === undefined)
                    obj[n] = def[n];
            }
        }
        return obj;
    }

    function getValue(target) {
        return target.value;
    }

    function hasClass(target, cls) {
        return target.className.match(new RegExp('(\\s|^)' + cls + '(\\s|$)'));
    }

    function addClass(target, cls) {
        if (!hasClass(target, cls)) target.className += " " + cls;
    }

    function removeClass(target, cls) {
        var reg = new RegExp('(\\s|^)' + cls + '(\\s|$)');
        target.className = target.className.replace(reg, ' ');
    }

    var Validator = function Validator(o) {
        if (!this.validate) return new Validator(o)
        this.opts = merge(o || {}, Validator.defaults)
    }

    Validator.defaults = {
        error_class: 'validate-error',
        empty_regex: /^\s*$/,
        email_regex: /^['a-zA-Z0-9._%+-]+@['a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/,
        int_regex: /^\s*(\+|-)?\d+\s*$/,
        decimal_regex: /^\s*(\+|-)?((\d+(\.\d+)?)|(\.\d+))\s*$/,
        phone_regex: /^[(]{0,1}[0-9]{3}[)]{0,1}[-\s\.]{0,1}[0-9]{3}[-\s\.]{0,1}[0-9]{4}$/,
        date_regex: /^((0?[1-9]|1[012])[- \/.](0?[1-9]|[12][0-9]|3[01])[- \/.](19|20)?[0-9]{2})*$/,
        url_regex: /^(http|https|ftp)\:\/\/([a-zA-Z0-9\.\-]+(\:[a-zA-Z0-9\.&amp;%\$\-]+)*@)*((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])|([a-zA-Z0-9\-]+\.)*[a-zA-Z0-9\-]+\.(com|edu|gov|int|mil|net|org|biz|arpa|info|name|pro|aero|coop|museum|[a-zA-Z]{2}))(\:[0-9]+)*(\/($|[a-zA-Z0-9\.\,\?\'\\\+&amp;%\$#\=~_\-]+))*$/
    };

    merge(Validator.prototype, {
        validate: function (param) {
            var self = this
            , o = self.opts;
            if (o['validation_group'] == undefined) return true;
            var el = jQuery('.' + o['validation_group']);
            var error = '';
            for (var i = 0; i < el.length; i++) {
                if (el[i].className.search('validate-notrequired') > -1) {
                    if (o.empty_regex.test(getValue(el[i])))
                        continue;
                }
                if (el[i].className.search('validate-email') > -1) {
                    if (o.email_regex.test(getValue(el[i])) == false) {
                        error += '<li>' + param[el[i].id] + '</li>';
                        jQuery(el[i]).addClass(o.error_class);
                    } else {
                        jQuery(el[i]).removeClass(o.error_class);
                    }
                }
                else if (el[i].className.search('validate-int') > -1) {
                    if (o.int_regex.test(getValue(el[i])) == false) {
                        error += '<li>' + param[el[i].id] + '</li>';
                        jQuery(el[i]).addClass(o.error_class);
                    } else {
                        jQuery(el[i]).removeClass(o.error_class);
                    }
                }
                else if (el[i].className.search('validate-decimal') > -1) {
                    if (o.decimal_regex.test(getValue(el[i])) == false) {
                        error += '<li>' + param[el[i].id] + '</li>';
                        jQuery(el[i]).addClass(o.error_class);
                    } else {
                        jQuery(el[i]).removeClass(o.error_class);
                    }
                }
                else if (el[i].className.search('validate-phone') > -1) {
                    if (o.phone_regex.test(getValue(el[i])) == false) {
                        error += '<li>' + param[el[i].id] + '</li>';
                        jQuery(el[i]).addClass(o.error_class);
                    } else {
                        jQuery(el[i]).removeClass(o.error_class);
                    }
                }
                else if (el[i].className.search('validate-date') > -1) {
                    if (o.empty_regex.test(getValue(el[i])) || o.date_regex.test(getValue(el[i])) == false) {
                        error += '<li>' + param[el[i].id] + '</li>';
                        jQuery(el[i]).addClass(o.error_class);

                    } else {
                        jQuery(el[i]).removeClass(o.error_class);
                    }
                }
                else if (el[i].className.search('validate-url') > -1) {
                    if (o.url_regex.test(getValue(el[i])) == false) {
                        error += '<li>' + param[el[i].id] + '</li>';
                        jQuery(el[i]).addClass(o.error_class);

                    } else {
                        jQuery(el[i]).removeClass(o.error_class);
                    }
                }
                else {
                    if (o.empty_regex.test(getValue(el[i]))) {
                        error += '<li>' + param[el[i].id] + '</li>';
                        jQuery(el[i]).addClass(o.error_class);
                    } else {
                        jQuery(el[i]).removeClass(o.error_class);
                    }
                }
            }
            if (error == '')
                error = self.error = undefined;
            else
                error = self.error = '<ul>' + error + '</ul>';
        },
        checkMinLength: function (targetID, minLength, msg) {
            var target = document.getElementById(targetID);
            if (target) {
                if (getValue(target).length >= minLength)
                    this.error = undefined;
                else
                    this.error = '<ul><li>' + msg + '</li></ul>';
            }
        },
        checkMaxLength: function (targetID, maxLength, msg) {
            var target = document.getElementById(targetID);
            if (target) {
                if (getValue(target).length > maxLength)
                    this.error = undefined;
                else
                    this.error = '<ul><li>' + msg + '</li></ul>';
            }
        }

    });

    if (typeof define == 'function' && define.amd)
        define(function () { return Validator })
    else
        window.Validator = Validator;
} (window, document, jQuery)