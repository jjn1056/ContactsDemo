package ContactsDemo::View::HTML::Contacts::Form;

use Moo;
use ContactsDemo::Syntax;
use ContactsDemo::View::HTML
  -tags => qw(div a fieldset link_to legend br form_for),
  -util => qw(path content);

has 'contact' => (is=>'ro', required=>1);

sub create_or_update_contact_path  :Renders ($self, $contact)  {
  return $contact->in_storage ?
   path('update', [$contact->id]) :
    path('create'); 
}

sub render($self, $c) {
  form_for 'contact', +{action=>$self->create_or_update_contact_path($self->contact)}, sub ($self, $fb, $contact) {
    div +{ if=>$fb->successfully_updated, 
      class=>'alert alert-success', role=>'alert' 
    }, 'Successfully Saved!',

    fieldset [
      $fb->legend,
      div +{ class=>'form-group' }, $fb->form_has_errors(),
      div +{ class=>'form-group' }, [
        $fb->label('first_name'),
        $fb->input('first_name'),
        $fb->errors_for('first_name'),
      ],
      div +{ class=>'form-group' }, [
        $fb->label('last_name'),
        $fb->input('last_name'),
        $fb->errors_for('last_name'),
      ],
      div +{ class=>'form-group' }, [
        $fb->label('notes'),
        $fb->text_area('notes'),
        $fb->errors_for('notes'),
      ],
    ],

    fieldset [
      div +{ class=>'form-group' }, [
        $fb->errors_for('emails'),
        $fb->fields_for('emails', sub($self, $fb_e, $e) {
          $fb_e->legend,
          div +{ class=>'form-row' }, [
            div +{ class=>'col form-group' }, [
              $fb_e->label('address'),
              $fb_e->input('address'),
              $fb_e->errors_for('address'),
            ],
            div +{ class=>'col form-group col-2' }, [
              $fb_e->label('_delete'), br,
              $fb_e->checkbox('_delete'),
            ],
          ]
        }, sub ($self, $fb_final, $new_e) {
          $fb_final->button( '_add', 'Add Email Address');
        }),
      ],
    ],

    fieldset [
      div +{ class=>'form-group' }, [
        $fb->errors_for('phones'),
        $fb->fields_for('phones', sub($self, $fb_e, $e) {
          $fb_e->legend,
          div +{ class=>'form-row' }, [
            div +{ class=>'col form-group' }, [
              $fb_e->label('phone_number'),
              $fb_e->input('phone_number'),
              $fb_e->errors_for('phone_number'),
            ],
            div +{ class=>'col form-group col-2' }, [
              $fb_e->label('_delete'), br,
              $fb_e->checkbox('_delete'),
            ],
          ]
        }, sub ($self, $fb_final, $new_e) {
          $fb_final->button( '_add', 'Add Phone Number');
        }),
      ],
    ],

    $fb->submit(),
    link_to path('list'), {class=>'btn btn-secondary btn-lg btn-block'}, 'Return to Contact List',
  },
  $self->delete_button;
}

sub delete_button :Renders ($self) {
  return '' unless $self->contact->in_storage;
  return form {
    method => 'POST',
    action => path('delete', [$self->contact->id], {'x-tunneled-method'=>'delete'}),
  },
    button { class => 'btn btn-danger btn-lg btn-block'}, 'Delete Contact';
}

1;
