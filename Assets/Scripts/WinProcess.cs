using Obi;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace Lick
{
    public class WinProcess : MonoBehaviour
    {
        public PlayerMove m_move;
        Rigidbody rb;

        public bool Replaying;
    void Start()
        {
            rb = GetComponent<Rigidbody>();
        }
        public void Player_Win()
        {
            m_move.is_start = false;
            StartCoroutine(JumpPreparing());
        }
        float touching_time = 0;
        bool is_touching;
        public float force = 1;
        void Update()
        {
            if (is_touching && touching_time < 3)
            {
                touching_time += Time.deltaTime;
                if (Replaying)
                {

                }
                else
                {
                    if (Input.GetKeyDown(KeyCode.Space))
                    {

                        target_1.localPosition = new Vector3(target_1.localPosition.x, target_1.localPosition.y, target_1.localPosition.z + 1f);
                        force += 1;
                    }
                }

            }
            else
            {
                if (is_touching)
                {
                    is_touching = false;
                    Jump();
                }
            }

        }
        void Jump()
        {
            attack_ment.enabled = false;
            m_move.SetBlendshapeWeigth(100);
            rb.constraints = RigidbodyConstraints.None;
            rb.velocity = new Vector3(0, 1, 1) * force*2;
            rb.AddTorque(transform.right * 50 * force);
            GetComponent<CharacterFlying>().StartFly();
        }
        public Transform jump_position;
        IEnumerator JumpPreparing()
        {
            Vector3 start_position;
            m_move.current_emoji = emoji.happy;
            float delta = 0;
            start_position = transform.position;
            while (delta < 1)
            {
                delta += Time.deltaTime;
                transform.position = Vector3.Lerp(start_position, jump_position.position, delta);
                m_move.SetBlendShapeEmoji(Mathf.Lerp(0, 100, delta));
                yield return new WaitForEndOfFrame();
            }
            is_touching = true;
            real_tongle.SetActive(false);
            rod_renderer.material = mat;
            attack_ment.enabled = true;
            yield return new WaitForSeconds(1);
            rod_pins_1.transform.position = target_1.position;
            
        }
        public ObiParticleAttachment attack_ment;
        public GameObject real_tongle;
        public GameObject rod_tongle;
        public GameObject rod_pins_1;
        public Transform target_1;
        public Material mat;
        public MeshRenderer rod_renderer;

    }
}

