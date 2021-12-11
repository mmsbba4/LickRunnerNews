using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace Lick
{
    public class bullet : MonoBehaviour
    {
        public Rigidbody rb;
        public float speed;
        public GameObject effect;
        private void OnEnable()
        {
            rb.velocity = transform.forward * speed;
        }
        private void OnTriggerEnter(Collider other)
        {
            Instantiate(effect, transform.position, Quaternion.identity);
            Destroy(gameObject);
        }
    }

}
