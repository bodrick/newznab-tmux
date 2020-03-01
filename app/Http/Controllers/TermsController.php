<?php

namespace App\Http\Controllers;

use App\Models\Settings;

class TermsController extends BasePageController
{
    /**
     * @throws \Exception
     */
    public function terms()
    {
        $this->setPrefs();
        $title = 'Terms and Conditions';
        $meta_title = config('app.name').' - Terms and conditions';
        $meta_keywords = 'terms,conditions';
        $meta_description = 'Terms and Conditions for '.config('app.name');

        $content = $this->smarty->fetch($this->theme.'/terms.tpl');

        $this->smarty->assign(compact('title', 'content', 'meta_title', 'meta_keywords', 'meta_description'));

        $this->smarty->display($this->theme.'/basepage.tpl');
    }
}
